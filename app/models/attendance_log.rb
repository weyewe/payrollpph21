class AttendanceLog < ActiveRecord::Base
    belongs_to :office
    
    validates_presence_of :enroll_id
    validates_presence_of :date
    validates_presence_of :in_out
    validates_presence_of :office_id
    
    #validates_uniqueness_of :code
    
    validate :valid_office_id
    
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
        new_object.enroll_id = params[:enroll_id]
        new_object.in_out = params[:in_out]
        
        if new_object.save
            obj_employee = Employee.where{
                    (enroll_id.eq params[:enroll_id])
                }.first
            
            current_employee_id = obj_employee.id
            
            current_check_time = (params[:date].hour * 60) + params[:date].min
            
            if (params[:in_out] == 0)
                obj_attendance = Attendance.where{
                    (employee_id.eq current_employee_id) &
                    (strftime("%Y-%m-%d",date).eq params[:date].to_date)
                }.first
                
                if obj_attendance.nil?
                    #Find shift id, start time and end time default
                    obj_shift = Shift.joins(:shift_allocations).where{
                        (shift_allocations.employee_id.eq current_employee_id) & 
                        ((start_time.gte current_check_time) |
                            (start_time.lte current_check_time))
                    }.first
                
                    Attendance.create_object(
                        :employee_id => current_employee_id,
                        :shift_id => obj_shift.id,
                        :date => params[:date],
                        :status => ATTENDANCE_STATUS[:present],
                        :time_in => current_check_time
                    )
                    
                    obj_attendance = Attendance.where{
                        (employee_id.eq current_employee_id) &
                        (strftime("%Y-%m-%d",date).eq params[:date].to_date)
                    }.first
                    
                    #Update late
                    if obj_attendance.time_in > obj_shift.start_time
                        obj_attendance.is_late = true
                        obj_attendance.late_minute = obj_attendance.time_in - obj_shift.start_time
                        obj_attendance.save
                    end
                end
            else
                obj_attendance = Attendance.where{
                    (employee_id.eq current_employee_id) &
                    (strftime("%Y-%m-%d",date).eq params[:date].to_date)
                }.first
                
                obj_attendance.update_object(
                    :time_out => current_check_time
                )
            end
        end
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.office_id = params[:office_id]
        self.date = params[:date]
        self.enroll_id = params[:enroll_id]
        self.in_out = params[:in_out]
        
        self.save
        
        return self 
    end
    
    #object.deleted_object
    def delete_object
        self.destroy 
    end
end
