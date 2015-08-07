class TrainingDetail < ActiveRecord::Base
    belongs_to :employee
    belongs_to :training
    
    validates_presence_of :training_id
    validates_presence_of :employee_id
    
    validate :valid_training_id
    validate :valid_employee_id
    validate :unique_employee_and_training_combination
    
    def unique_employee_and_training_combination
        return if not employee_id.present? 
        return if not training_id.present?
        
        past_data_list = TrainingDetail.where(
                :employee_id => self.employee_id,
                :training_id => self.training_id,
                :is_deleted => false 
            )
            
        if not self.persisted? and past_data_list.count != 0
            self.errors.add(:training_id, "Training dan employee tidak boleh duplicate")
            self.errors.add(:employee_id, "Training dan employee tidak boleh duplicate")
            return self
        elsif self.persisted? and past_data_list.count > 0 
            past_data = past_data_list.first 
            if past_data.id != self.id
                self.errors.add(:training_id, "Training dan employee tidak boleh duplicate")
                return self 
            end
        end
        
    end
    
    def valid_training_id
        return if not training_id.present? 
        
        object = Training.find_by_id training_id 
        
        if object.nil?
            self.errors.add(:training_id, "Harus ada training id")
            return self
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
    
    def self.create_object( params )
        new_object = self.new
        
        new_object.training_id = params[:training_id]
        new_object.employee_id = params[:employee_id]
        
        if new_object.save 
            #Find training master information
            object = Training.where(
                :id => params[:training_id]
            ).first
            
            #Create on employee training
            EmployeeTraining.create_object(
                :employee_id => params[:employee_id],
                :start_date => object.start_date,
                :end_date => object.end_date,
                :subject => object.subject,
                :organizer => object.trainer,
                :place => object.location
            )

            date_start = object.start_date
            date_end  = object.end_date
            diff = (date_end - date_start).to_i / (24 * 60 * 60)
            
            #Insert into attendance for x days with duty status
            (0.upto diff).each do |x|
                the_date = date_start + x.days
                
                #Find shift id, start time and end time default
                obj_shift = ShiftDetail.joins(:shift => [:shift_allocations => [:employee]]).where{   
                        (shift.shift_allocations.employee_id.eq params[:employee_id] ) & 
                        (start_time.gte 480) &
                        (day_code.eq the_date.wday)
                    }.first
            
                Attendance.create_object(
                    :employee_id => params[:employee_id],
                    :shift_id => obj_shift.shift_id,
                    :date => the_date,
                    :status => ATTENDANCE_STATUS[:duty],
                    :time_in => obj_shift.start_time,
                    :time_out => obj_shift.start_time + (obj_shift.duration * 60),
                    :description => object.description 
                )
            end
            
        end
        
        return new_object
    end
    
    def update_object( params )
        self.training_id = params[:training_id]
        self.employee_id = params[:employee_id]
        
        self.save   
        
        return save
    end
    
    def delete_object

        if self.is_deleted
            self.errors.add(:generic_errors, "Sudah di delete")
            return self
        end
        
        self.is_deleted = true
        self.deleted_at = DateTime.now 
        
        if self.save 
            current_employee_id = self.employee_id
            object = Training.where(
                :id => self.training_id
            ).first
            
            object_attendance = Attendance.where{
                (employee_id.eq current_employee_id) & 
                ((strftime("%Y-%m-%d",date).gte object.start_date.to_date) &
                    (strftime("%Y-%m-%d",date).lte object.end_date.to_date)) & 
                (status.eq ATTENDANCE_STATUS[:duty]) &
                (is_deleted.eq false)
            }.each do |att|
                att.delete_object
            end
            
            object_emp_training = EmployeeTraining.where(
                :employee_id => current_employee_id,
                :subject => object.subject,
                :start_date => object.start_date,
                :end_date => object.end_date
            ).first
            
            object_emp_training.destroy
        end
    end
end
