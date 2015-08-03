class Attendance < ActiveRecord::Base
    belongs_to :employee
    belongs_to :shift
    
    validates_presence_of :employee_id
    validates_presence_of :shift_id
    validates_presence_of :date
    validates_presence_of :status
    
    #validates_uniqueness_of :code
    
    validate :valid_employee_id
    validate :valid_shift_id
    
    def valid_employee_id
        return if not employee_id.present? 
        
        object = Employee.find_by_id employee_id 
        
        if object.nil?
            self.errors.add(:employee_id, "Harus ada employee id")
            return self
        end
    end
    
    def valid_shift_id
        return if not shift_id.present? 
        
        object = Shift.find_by_id shift_id 
        
        if object.nil?
            self.errors.add(:shift_id, "Harus ada shift id")
            return self
        end
    end
    
    #object.create_object
    def self.create_object( params ) 
        new_object = self.new
      
        new_object.employee_id = params[:employee_id]
        new_object.shift_id = params[:shift_id]
        new_object.date = params[:date]
        new_object.status = params[:status]
        new_object.time_in = params[:time_in]
        new_object.time_out = params[:time_out]
        new_object.description = params[:description]
        
        if new_object.save
            the_date = params[:date]
            
            #Find start time default
            obj_shift = ShiftDetail.joins(:shift).where{
                (shift.id.eq params[:shift_id]) &
                (day_code.eq the_date.wday)
            }.first
            
            #Update late
            if not new_object.time_in.nil? 
                if new_object.time_in > obj_shift.start_time
                    new_object.is_late = true
                    new_object.late_minute = new_object.time_in - obj_shift.start_time
                    new_object.save
                end
            end
            
            # Attendance.where{
            #     (time_in.gte duty.start_date ) &    #gte grather than equal
            #     (time_in.lt duty.end_date )         #lt less than
            # }.each do |x|
            #     x.time_in
            #     x.time_out
            # end
        end
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.employee_id = params[:employee_id]
        self.shift_id = params[:shift_id]
        self.date = params[:date]
        self.status = params[:status]
        self.time_in = params[:time_in]
        self.time_out = params[:time_out]
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
        
        self.is_deleted = true
        self.deleted_at = DateTime.now 
        
        self.save
    end
end
