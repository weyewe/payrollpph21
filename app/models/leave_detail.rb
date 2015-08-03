class LeaveDetail < ActiveRecord::Base
    belongs_to :employee
    
    validates_presence_of :period_year
    validates_presence_of :employee_id
    
    #validates_uniqueness_of :code
    
    validate :valid_employee_id
    validate :unique_period_year
    
    def unique_period_year
        return if not employee_id.present?
        
        past_data_list = LeaveDetail.where(
                :employee_id => self.employee_id,
                :period_year => self.period_year
            )
            
        if not self.persisted? and past_data_list.count != 0
            self.errors.add(:period_year, "tidak boleh duplicate")
            return self
        elsif self.persisted? and past_data_list.count > 0 
            past_data = past_data_list.first 
            if past_data.id != self.id
                self.errors.add(:period_year, "tidak boleh duplicate")
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
    
    #new_object.create_object
    def self.create_object( params ) 
        new_object = self.new
        
        new_object.employee_id = params[:employee_id]
        new_object.start_working = params[:start_working]
        new_object.period_year = params[:period_year]
        new_object.start_period = params[:start_period]
        new_object.end_period = params[:end_period]
        new_object.max_leave = params[:max_leave]
        new_object.used_leave = params[:used_leave]
        new_object.current_leave = params[:current_leave]
        
        new_object.save
        
        return new_object
    end
    
    # new_object.update_object 
    def update_object( params )
        self.employee_id = params[:employee_id]
        self.start_working = params[:start_working]
        self.period_year = params[:period_year]
        self.start_period = params[:start_period]
        self.end_period = params[:end_period]
        self.max_leave = params[:max_leave]
        self.used_leave = params[:used_leave]
        self.current_leave = params[:current_leave]
        
        self.save
        
        return self 
    end
    
    #new_object.deleted_object
    def delete_object
        self.destroy
    end
end
