class Decree < ActiveRecord::Base
    belongs_to :employee
    
    validates_presence_of :no
    validates_presence_of :date
    validates_presence_of :employee_id
    validates_presence_of :office_id
    validates_presence_of :branch_office_id
    validates_presence_of :department_id
    validates_presence_of :division_id
    validates_presence_of :title_id
    validates_presence_of :sk_type
    
    validate :valid_office_id
    validate :valid_branch_office_id
    validate :valid_department_id
    validate :valid_division_id
    validate :valid_title_id
    validate :valid_employee_id
    validate :unique_no
    
    def unique_no
        return if not office_id.present? 
        
        past_data_list = Decree.where(
                :office_id => self.office_id,
                :no => self.no,
                :is_deleted => false
            )
            
        if not self.persisted? and past_data_list.count != 0
            self.errors.add(:no, "No tidak boleh duplicate")
            return self
        elsif self.persisted? and past_data_list.count > 0 
            past_data = past_data_list.first 
            if past_data.id != self.id
                self.errors.add(:no, "No tidak boleh duplicate")
                return self 
            end
        end
    end
    
    def valid_employee_id
        return if not employee_id.present? 
        
        object = Employee.find_by_id employee_id 
        
        if object.nil?
            self.errors.add(:office_id, "Harus ada employee id")
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
        
        new_object.no = params[:no]
        new_object.date = params[:date]
        new_object.employee_id = params[:employee_id]
        new_object.office_id = params[:office_id]
        new_object.branch_office_id = params[:branch_office_id]
        new_object.department_id = params[:department_id]
        new_object.division_id = params[:division_id]
        new_object.title_id = params[:title_id]
        new_object.sk_type = params[:sk_type]
        
        if new_object.save
            object = Employee.where(
                :office_id => params[:office_id],
                :id => params[:employee_id]
            ).first
            
            object.update_object(
                    :office_id => params[:office_id],
                    :branch_office_id => params[:branch_office_id],
                    :department_id => params[:department_id],
                    :division_ide => params[:division_id],
                    :title_id => params[:title_id]
                )
        end
        
        return new_object
    end
    
    # employee_object.update_object 
    def update_object( params ) 
        current_office_id = self.office_id
        current_branch_office_id = self.branch_office_id
        current_department_id = self.department_id
        current_division_id = self.division_id
        current_title_id = self.title_id
        
        self.no = params[:no]
        self.date = params[:date]
        self.employee_id = params[:employee_id]
        self.office_id = params[:office_id]
        self.branch_office_id = params[:branch_office_id]
        self.department_id = params[:department_id]
        self.division_id = params[:division_id]
        self.title_id = params[:title_id]
        self.sk_type = params[:sk_type]
        
        if self.save
            if current_office_id != self.office_id or 
                current_branch_office_id != self.branch_office_id or 
                current_department_id != self.department_id or 
                current_division_id != self.division_id or 
                current_title_id != self.title_id
            
                object = Employee.where(
                        :office_id => self.office_id,
                        :id => self.employee_id
                    )
                
                object.update_object(
                        :office_id => current_office_id,
                        :branch_office_id => current_branch_office_id,
                        :department_id => current_department_id,
                        :division_ide => current_division_id,
                        :title_id => current_title_id
                    )
            end
        end
        
        return self 
    end
    
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
