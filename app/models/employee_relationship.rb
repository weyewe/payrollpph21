class EmployeeRelationship < ActiveRecord::Base
    belongs_to :employee
    
    validates_presence_of :employee_id
    validates_presence_of :name
    validates_presence_of :relationship
    
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
        new_object.name = params[:name]
        new_object.relationship = params[:relationship]
        new_object.date_of_birth = params[:date_of_birth]
        new_object.gender = params[:gender]
        new_object.education = params[:education]
        new_object.employment = params[:employment]
        new_object.address = params[:address]
        
        new_object.save
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.employee_id = params[:employee_id]
        self.name = params[:name]
        self.relationship = params[:relationship]
        self.date_of_birth = params[:date_of_birth]
        self.gender = params[:gender]
        self.education = params[:education]
        self.employment = params[:employment]
        self.address = params[:address]
        
        self.save
        
        return self 
    end
    
    #object.deleted_object
    def delete_object
        self.destroy 
    end
end
