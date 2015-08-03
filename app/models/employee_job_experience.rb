class EmployeeJobExperience < ActiveRecord::Base
    belongs_to :employee
    
    validates_presence_of :employee_id
    validates_presence_of :company_name
    validates_presence_of :range_year
    
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
        new_object.company_name = params[:company_name]
        new_object.range_year = params[:range_year]
        new_object.last_job_title = params[:last_job_title]
        new_object.last_salary = params[:last_salary]
        new_object.end_working_reason = params[:end_working_reason]
        new_object.description = params[:description]
        
        new_object.save
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.employee_id = params[:employee_id]
        self.company_name = params[:company_name]
        self.range_year = params[:range_year]
        self.last_job_title = params[:last_job_title]
        self.last_salary = params[:last_salary]
        self.end_working_reason = params[:end_working_reason]
        self.description = params[:description]
        
        self.save
        
        return self 
    end
    
    #object.deleted_object
    def delete_object
        self.destroy 
    end
end
