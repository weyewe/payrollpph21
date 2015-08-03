class Recruitment < ActiveRecord::Base
    belongs_to :division
    belongs_to :title
    belongs_to :level
    belongs_to :status_working
    
    validates_presence_of :identity_number
    validates_presence_of :name
    validates_presence_of :office_id
    validates_presence_of :branch_office_id
    validates_presence_of :department_id
    validates_presence_of :division_id
    validates_presence_of :title_id
    validates_presence_of :level_id
    validates_presence_of :status_working_id
    
    validate :valid_office_id
    validate :valid_branch_office_id
    validate :valid_department_id
    validate :valid_division_id
    validate :valid_title_id
    validate :valid_level_id
    validate :valid_status_working_id
    validate :unique_identity_number
    
    def unique_identity_number
        return if not office_id.present? 
        
        past_data_list = Recruitment.where(
                :office_id => self.office_id,
                :identity_number => self.identity_number
            )
            
        if not self.persisted? and past_data_list.count != 0
            self.errors.add(:identity_number, "Identity Number tidak boleh duplicate")
            return self
        elsif self.persisted? and past_data_list.count > 0
            past_data = past_data_list.first 
            if past_data.id != self.id
                self.errors.add(:identity_number, "Identity Number tidak boleh duplicate")
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
    
    def valid_level_id
        return if not level_id.present? 
        
        object = Level.find_by_id level_id 
        
        if object.nil?
            self.errors.add(:level_id, "Harus ada level id")
            return self
        end
    end
    
    def valid_status_working_id
        return if not status_working_id.present? 
        
        object = StatusWorking.find_by_id status_working_id 
        
        if object.nil?
            self.errors.add(:status_working_id, "Harus ada working status id")
            return self
        end
    end
    
    def self.create_object( params ) 
        
        new_object = self.new  # new_object = Employee.new
      
        new_object.identity_number = params[:identity_number]
        new_object.name = params[:name]
        new_object.place_of_birth = params[:place_of_birth]
        new_object.date_of_birth = params[:date_of_birth]
        new_object.gender = params[:gender]
        new_object.religion = params[:religion]
        new_object.phone = params[:phone]
        new_object.address = params[:address]
        new_object.office_id = params[:office_id]
        new_object.branch_office_id = params[:branch_office_id]
        new_object.department_id = params[:department_id]
        new_object.division_id = params[:division_id]
        new_object.title_id = params[:title_id]
        new_object.level_id = params[:level_id]
        new_object.status_working_id = params[:status_working_id]
        new_object.date_application = params[:date_application]
        new_object.date_psikotest = params[:date_psikotest]
        new_object.date_interview = params[:date_interview]
        new_object.description = params[:description]
        new_object.is_bank_data = params[:is_bank_data]
        
        new_object.save
        
        return new_object
    end
    
    # employee_object.update_object 
    def update_object( params ) 
        self.identity_number = params[:identity_number]
        self.name = params[:name]
        self.place_of_birth = params[:place_of_birth]
        self.date_of_birth = params[:date_of_birth]
        self.gender = params[:gender]
        self.religion = params[:religion]
        self.phone = params[:phone]
        self.address = params[:address]
        self.office_id = params[:office_id]
        self.branch_office_id = params[:branch_office_id]
        self.department_id = params[:department_id]
        self.division_id = params[:division_id]
        self.title_id = params[:title_id]
        self.level_id = params[:level_id]
        self.status_working_id = params[:status_working_id]
        self.date_application = params[:date_application]
        self.date_psikotest = params[:date_psikotest]
        self.date_interview = params[:date_interview]
        self.description = params[:description]
        self.is_bank_data = params[:is_bank_data]
        
        self.save
            
        return self 
    end
    
    def delete_object
        self.destroy 
    end
    
    def send_to_bank_data
        if self.is_bank_data
            self.errors.add(:generic_errors, "Sudah di bank data")
            return self
        end
        
        self.is_bank_data = true
        self.save 
    end
    
    def send_to_recruitment
        if not self.is_bank_data
            self.errors.add(:generic_errors, "Sudah di bank recruitment")
            return self
        end
        
        self.is_bank_data = false
        self.save 
    end
end
