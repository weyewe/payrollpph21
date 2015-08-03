class EmployeeEducation < ActiveRecord::Base
    belongs_to :employee
    
    validates_presence_of :employee_id
    validates_presence_of :level
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
        new_object.level = params[:level]
        new_object.range_year = params[:range_year]
        new_object.majors = params[:majors]
        new_object.school = params[:school]
        new_object.city = params[:city]
        new_object.country = params[:country]
        
        new_object.save
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.employee_id = params[:employee_id]
        self.level = params[:level]
        self.range_year = params[:range_year]
        self.majors = params[:majors]
        self.school = params[:school]
        self.city = params[:city]
        self.country = params[:country]
        
        self.save
        
        return self 
    end
    
    #object.deleted_object
    def delete_object
        self.destroy 
    end
end
