class Job < ActiveRecord::Base
    belongs_to :employee
    
    validates_presence_of :employee_id
    validates_presence_of :start_date
    validates_presence_of :end_date
    validates_presence_of :destination
    
    #validates_uniqueness_of :code
    
    validate :valid_employee_id
    
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
        new_object.start_date = params[:start_date]
        new_object.end_date = params[:end_date]
        new_object.destination = params[:destination]
        new_object.description = params[:description]
        
        if new_object.save
            #Find job information
            object = Job.where(
                :id => new_object.id
            ).first
            
            #Find difference from date start and date end
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
    
    # object.update_object 
    def update_object( params )
        self.employee_id = params[:employee_id]
        self.start_date = params[:start_date]
        self.end_date = params[:end_date]
        self.destination = params[:destination]
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
        
        current_employee_id = self.employee_id
        current_start_date = self.start_date
        current_end_date = self.end_date
        
        Attendance.where{
            (employee_id.eq current_employee_id) &
            ((strftime("%Y-%m-%d",date).gte current_start_date.to_date) &
                (strftime("%Y-%m-%d",date).lte current_end_date.to_date)) &
            (is_deleted.eq false)
        }.each do |att|
            att.delete_object
        end
        
        self.is_deleted = true
        self.deleted_at = DateTime.now 
        
        self.save
    end
end
