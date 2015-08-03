class Division < ActiveRecord::Base
    has_many :employees
    has_many :recruitments
    belongs_to :department
    
    validates_presence_of :code
    validates_presence_of :name
    validates_presence_of :office_id
    validates_presence_of :branch_office_id
    validates_presence_of :department_id
    
    validate :valid_office_id
    validate :valid_branch_office_id
    validate :valid_department_id
    validate :unique_code
    
    def unique_code
        return if not office_id.present?
        return if not branch_office_id.present? 
        return if not department_id.present? 
        
        past_data_list = Division.where(
                :office_id => self.office_id,
                :branch_office_id => self.branch_office_id,
                :department_id => self.department_id,
                :code => self.code
            )
            
        if not self.persisted? and past_data_list.count != 0
            self.errors.add(:code, "Code tidak boleh duplicate")
            return self
        elsif self.persisted? and past_data_list.count > 0 
            past_data = past_data_list.first 
            if past_data.id != self.id
                self.errors.add(:code, "Code tidak boleh duplicate")
                return self 
            end
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
    
    #object.create_object
    def self.create_object( params ) 
        new_object = self.new
        
        new_object.office_id = params[:office_id]
        new_object.branch_office_id = params[:branch_office_id]
        new_object.department_id = params[:department_id]
        new_object.code = params[:code]
        new_object.name = params[:name]
        new_object.description = params[:description]
        
        new_object.save
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.office_id = params[:office_id]
        self.branch_office_id = params[:branch_office_id]
        self.department_id = params[:department_id]
        self.code = params[:code]
        self.name = params[:name]
        self.description = params[:description]
        
        self.save
        
        return self 
    end
    
    #object.deleted_object
    def delete_object
        # 1. jika sudah ada division, tidak boleh di delete
        if self.employees.count != 0 
            self.errors.add(:generic_errors, "sudah ada division")
            return self 
        end
        
        self.destroy 
    end
end
