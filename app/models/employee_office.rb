class EmployeeOffice < ActiveRecord::Base
    belongs_to :employee
    
    validates_presence_of :office_id
    validates_presence_of :branch_office_id
    validates_presence_of :department_id
    validates_presence_of :division_id
    validates_presence_of :title_id
    validates_presence_of :employee_id
    
    validate :valid_employee_id
    validate :valid_office_id
    validate :valid_branch_office_id
    validate :valid_department_id
    validate :valid_division_id
    validate :valid_title_id
    
    def valid_employee_id
        return if not employee_id.present? 
        
        object = Employee.find_by_id employee_id 
        
        if object.nil?
            self.errors.add(:employee_id, "Harus ada employee id")
            return self
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
    
    def valid_branch_office_id
        return if not branch_office_id.present? 
        
        object = BranchOffice.find_by_id branch_office_id 
        
        if object.nil?
            self.errors.add(:branch_office_id, "Harus ada branch office id")
            return self
        end
    end
    
    def valid_department_id
        return if not department_id.present? 
        
        object = Department.find_by_id department_id 
        
        if object.nil?
            self.errors.add(:department_id, "Harus ada department id")
            return self
        end
    end
    
    def valid_division_id
        return if not division_id.present? 
        
        object = Division.find_by_id division_id 
        
        if object.nil?
            self.errors.add(:division_id, "Harus ada division id")
            return self
        end
    end
    
    def valid_title_id
        return if not title_id.present? 
        
        object = Title.find_by_id title_id 
        
        if object.nil?
            self.errors.add(:title_id, "Harus ada title id")
            return self
        end
    end
    
    def self.create_object( params ) 
        new_object = self.new  # new_object = Employee.new
        
        new_object.employee_id = params[:employee_id]
        new_object.office_id = params[:office_id]
        new_object.branch_office_id = params[:branch_office_id]
        new_object.department_id = params[:department_id]
        new_object.division_id = params[:division_id]
        new_object.title_id = params[:title_id]
        
        new_object.save
        
        return new_object
    end
end
