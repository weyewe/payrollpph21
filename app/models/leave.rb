class Leave < ActiveRecord::Base
    belongs_to :employee
    
    validates_presence_of :date
    validates_presence_of :description
    validates_presence_of :employee_id
    
    #validates_uniqueness_of :code
    
    validate :valid_employee_id
    validate :unique_date
    
    def unique_date
        return if not employee_id.present?
        
        past_data_list = Leave.where(
                :employee_id => self.employee_id,
                :date => self.date,
                :is_deleted => false
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
    
    def valid_employee_id
        return if not employee_id.present? 
        
        object = Employee.find_by_id employee_id 
        
        if object.nil?
            self.errors.add(:employee_id, "Harus ada employee id")
            return self
        end
    end
    
    #object.create_object
    def self.create_object( params ) 
        new_object = self.new
        
        new_object.employee_id = params[:employee_id]
        new_object.date = params[:date]
        new_object.description = params[:description]
        
        new_object.save
        
            # #Find shift id, start time and duration default
            # obj_shift = Shift.joins(:shift_allocations).where{
            #     (shift_allocations.employee_id.eq params[:employee_id] ) & 
            #     (start_time.gte 480)
            # }.first
            
            # #Insert into attendance with leave status
            # Attendance.create_object(
            #     :employee_id => params[:employee_id],
            #     :shift_id => obj_shift.id,
            #     :date => params[:date],
            #     :status => ATTENDANCE_STATUS[:leave],
            #     :time_in => obj_shift.start_time,
            #     :time_out => obj_shift.start_time + obj_shift.duration,
            #     :description => params[:description] 
            # )
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.employee_id = params[:employee_id]
        self.date = params[:date]
        self.description = params[:description]
        
        self.save
        
        return self 
    end
    
    #object.deleted_object
    def delete_object
        if self.is_deleted
            self.errors.add(:generic_errors, "Sudah di delete")
            return self
        end
        
        if self.is_approved
            self.errors.add(:generic_errors, "Sudah di approve")
            return self
        end
        
        self.is_deleted = true
        self.deleted_at = DateTime.now 
        self.save 
    end
    
    #object.approve_object
    def approve_object
        if self.is_approved
            self.errors.add(:generic_errors, "Sudah di approve")
            return self
        end
        
        self.is_approved = true
        self.approved_at = DateTime.now 
        
        if self.save
            current_employee_id = self.employee_id
            current_date = self.date
            current_description = self.description
            
            obj_leave_detail = LeaveDetail.where{
                (employee_id.eq current_employee_id) &
                ((start_period.lte current_date) &
                    (end_period.gte current_date))
            }.first
            
            current_leave = obj_leave_detail.current_leave
            current_used_leave = obj_leave_detail.used_leave
            
            if current_leave > 0
                obj_leave_detail.used_leave = current_used_leave + 1
                obj_leave_detail.current_leave = current_leave - 1
                obj_leave_detail.save
                
                #Find shift id, start time and duration default
                obj_shift = Shift.joins(:shift_allocations).where{
                    (shift_allocations.employee_id.eq current_employee_id ) & 
                    (start_time.gte 480)
                }.first
                
                #Insert into attendance with leave status
                Attendance.create_object(
                    :employee_id => current_employee_id,
                    :shift_id => obj_shift.id,
                    :date => current_date,
                    :status => ATTENDANCE_STATUS[:leave],
                    :time_in => obj_shift.start_time,
                    :time_out => obj_shift.start_time + obj_shift.duration,
                    :description => current_description 
                )
            else
                self.errors.add(:employee_id, "Tidak punya cuti yang tersisa")
                return self
            end
        end
    end
    
    #object.unapprove_object
    def unapprove_object
        if not self.is_approved
            self.errors.add(:generic_errors, "Sudah di unapprove")
            return self
        end
        
        self.is_approved = false
        self.approved_at = nil
        
        if self.save
            current_employee_id = self.employee_id
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
            
            #Find shift id, start time and duration default
            obj_shift = Shift.joins(:shift_allocations).where{
                (shift_allocations.employee_id.eq current_employee_id ) & 
                (start_time.gte 480)
            }.first
            
            obj_attendance = Attendance.where{
                (employee_id.eq current_employee_id) &
                (strftime("%Y-%m-%d",date).eq current_date.to_date) &
                (status.eq ATTENDANCE_STATUS[:leave])
            }.first
            
            obj_attendance.destroy
        end
    end
    
    def self.generate_object( params )
        Employee.where{
            (office_id.eq params[:office_id]) &
            (is_not_active.eq false)
        }.each do |emp|
            current_start_working = emp.start_working
            
            #Mencari 1 tahun setelah start working
            new_start_working_for_year = current_start_working + 12.months - 1.days
            
            #Jika belum ada 1 tahun, belum mendapat jatah cuti
            if params[:date] >= new_start_working_for_year
                new_max_leave = 12
            else
                new_max_leave = 0
            end
            
            new_year_diff = params[:date].year - current_start_working.year
            new_period_start = current_start_working + new_year_diff.years
            new_period_end = new_period_start + 12.months - 1.days
            
            new_count_leave = Attendance.where{
                    (employee_id.eq emp.id) &
                    ((strftime("%Y-%m-%d",date).gte new_period_start.to_date) & 
                        (strftime("%Y-%m-%d",date).lte new_period_end.to_date)) &
                    ((status.eq ATTENDANCE_STATUS[:leave]) |
                        (status.eq ATTENDANCE_STATUS[:general_leave]))
                }.count
            
            obj_leave_detail = LeaveDetail.where{
                (employee_id.eq emp.id) &
                (period_year.eq params[:date].year)
            }.first
            
            obj_leave_detail.destroy
            
            LeaveDetail.create_object(
                :employee_id => emp.id,
                :start_working => current_start_working,
                :period_year => params[:date].year,
                :start_period => new_period_start,
                :end_period => new_period_end,
                :max_leave => new_max_leave,
                :used_leave => new_count_leave,
                :current_leave => new_max_leave - new_count_leave
            )
        end
    end
end
