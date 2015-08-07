class GeneralLeave < ActiveRecord::Base
    belongs_to :office
    
    validates_presence_of :date
    validates_presence_of :description
    validates_presence_of :office_id
    
    #validates_uniqueness_of :code
    
    validate :valid_office_id
    validate :unique_date
    
    def unique_date
        return if not office_id.present? 
        
        past_data_list = GeneralLeave.where(
                :office_id => self.office_id,
                :date => self.date
            )
            
        if not self.persisted? and past_data_list.count != 0
            self.errors.add(:date, "tidak boleh duplicate")
            return self
        elsif self.persisted? and past_data_list.count > 0 
            past_data = past_data_list.first 
            if past_data.id != self.id
                self.errors.add(:date, "tidak boleh duplicate")
                return self 
            end
        end
    end
    
    def valid_office_id
        return if not office_id.present? 
        
        object = Office.find_by_id office_id 
        
        if object.nil?
            self.errors.add(:office_id, "Harus ada office id")
            return self
        end
    end
    
    #object.create_object
    def self.create_object( params ) 
        new_object = self.new
        
        new_object.office_id = params[:office_id]
        new_object.date = params[:date]
        new_object.description = params[:description]
        
        if new_object.save
            #Find employee active on selected office
            Employee.where{
                (office_id.eq params[:office_id] ) &
                (is_not_active.eq false )         #lt less than
            }.each do |x|
                current_employee_id = x.id
                current_date = params[:date]
                current_description = params[:description]
                
                obj_leave_detail = LeaveDetail.where{
                    (employee_id.eq current_employee_id) &
                    ((strftime("%Y-%m-%d",start_period).lte current_date.to_date) &
                        (strftime("%Y-%m-%d",end_period).gte current_date.to_date))
                }.first
                
                current_leave = obj_leave_detail.current_leave
                current_used_leave = obj_leave_detail.used_leave
                
                obj_leave_detail.used_leave = current_used_leave + 1
                obj_leave_detail.current_leave = current_leave - 1
                obj_leave_detail.save
                
                #Find shift id, start time and duration dfault
                obj_shift = ShiftDetail.joins(:shift => [:shift_allocations => [:employee]]).where{   
                        (shift.shift_allocations.employee_id.eq current_employee_id ) & 
                        (start_time.gte 480) &
                        (day_code.eq params[:date].wday)
                    }.first
                
                Attendance.create_object(
                    :employee_id => x.id,
                    :shift_id => obj_shift.shift_id,
                    :date => params[:date],
                    :status => ATTENDANCE_STATUS[:general_leave],
                    :time_in => obj_shift.start_time,
                    :time_out => obj_shift.start_time + (obj_shift.duration * 60),
                    :description => params[:description] 
                )
            end
        end
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.office_id = params[:office_id]
        self.date = params[:date]
        self.description = params[:description]
        
        self.save
        
        return self 
    end
    
    #object.deleted_object
    def delete_object
        if self.destroy 
            #Find employee active on selected office
            Employee.where{
                (office_id.eq self.office_id ) &
                (is_not_active.eq false )         #lt less than
            }.each do |x|
                current_employee_id = x.id
                current_date = self.date
                
                obj_leave_detail = LeaveDetail.where{
                    (employee_id.eq current_employee_id) &
                    ((strftime("%Y-%m-%d",start_period).lte current_date.to_date) &
                        (strftime("%Y-%m-%d",end_period).gte current_date.to_date))
                }.first
                
                current_leave = obj_leave_detail.current_leave
                current_used_leave = obj_leave_detail.used_leave
                
                obj_leave_detail.used_leave = current_used_leave - 1
                obj_leave_detail.current_leave = current_leave + 1
                obj_leave_detail.save
                
                #Delete Attendance
                obj_attendance = Attendance.where{
                    (employee_id.eq current_employee_id) &
                    (strftime("%Y-%m-%d",date).eq current_date.to_date) &
                    (status.eq ATTENDANCE_STATUS[:general_leave])
                }.first
                
                obj_attendance.destroy
            end
        end
    end
end
