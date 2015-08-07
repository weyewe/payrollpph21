class Pkwt < ActiveRecord::Base
    belongs_to :employee
    belongs_to :recruitment
    
    validates_presence_of :office_id
    validates_presence_of :no
    # validates_presence_of :is_employee
    validates_presence_of :employee_id
    validates_presence_of :length_of_contract
    validates_presence_of :start_date
    validates_presence_of :end_date
    
    #validates_uniqueness_of :code
    
    validate :valid_office_id
    validate :valid_employee_id
    validate :unique_no
    validate :not_zero_length_of_contract
    
    def not_zero_length_of_contract
        return if not length_of_contract.present?
        
        if length_of_contract <= 0
            self.errors.add(:length_of_contract, "Tidak boleh lebih kecil dari 0")
            return self
        end
    end
    
    def unique_no
        return if not office_id.present? 
        
        past_data_list = Pkwt.where(
                :office_id => self.office_id,
                :no => self.no,
                :is_deleted => false
            )
        
        if not self.persisted? and past_data_list.count != 0
            self.errors.add(:no, "No tidak boleh duplicate zaaa")
            return self
        elsif self.persisted? and past_data_list.count > 0 
            past_data = past_data_list.first 
            if past_data.id != self.id
                self.errors.add(:no, "No tidak boleh duplicate bbbb")
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
    
    def valid_employee_id
        if self.is_employee == true
            return if not employee_id.present? 
            
            object = Employee.find_by_id employee_id 
            
            if object.nil?
                self.errors.add(:employee_id, "Harus ada employee id")
                return self
            end
        else
            return if not employee_id.present? 
            
            object = Recruitment.find_by_id employee_id 
            
            if object.nil?
                self.errors.add(:employee_id, "Harus ada employee id")
                return self
            end
        end
    end
    
    #object.create_object
    def self.create_object( params ) 
        new_object = self.new
      
        new_object.office_id = params[:office_id]
        new_object.no = params[:no]
        new_object.is_employee = params[:is_employee]
        new_object.employee_id = params[:employee_id]
        new_object.length_of_contract = params[:length_of_contract]
        new_object.start_date = params[:start_date]
        new_object.end_date = params[:end_date]
        new_object.description = params[:description]
        
        if new_object.save
            current_is_employee = params[:is_employee]
            current_start_date = params[:start_date]
            
            #Insert into employee if this data not in employee table
            if current_is_employee == false
                object = Recruitment.where(
                    :id => params[:employee_id]
                    ).first
                
                new_identity_number = object.identity_number
                new_name = object.name
                new_place_of_birth = object.place_of_birth
                new_date_of_birth = object.date_of_birth
                new_gender = object.gender
                new_religion = object.religion
                new_phone = object.phone
                new_address = object.address
                new_office_id = object.office_id
                new_branch_office_id = object.branch_office_id
                new_department_id = object.department_id
                new_division_id = object.division_id
                new_title_id = object.title_id
                new_level_id = object.level_id
                new_status_working_id = object.status_working_id
                
                
                @employee = Employee.create_object(
                    :office_id => new_office_id,
                    :branch_office_id => new_branch_office_id,
                    :department_id => new_department_id,
                    :division_id => new_department_id,
                    :title_id => new_title_id,
                    :level_id => new_level_id,
                    :status_working_id => new_status_working_id,
                    :code => new_identity_number,
                    :full_name => new_name,
                    :nick_name => new_name,
                    :enroll_id => 0,
                    :place_of_birth => new_place_of_birth,
                    :date_of_birth => new_date_of_birth,
                    :gender => new_gender,
                    :religion => new_religion,
                    :phone => new_phone,
                    :address => new_address,
                    :start_working => current_start_date,
                    :identity_number => new_identity_number
                  )
                  
                EmployeeContract.create_object(
                    :employee_id => @employee.id,
                    :start_date => params[:start_date],
                    :end_date => params[:end_date],
                    :no => params[:no],
                    :description => params[:description]
                  )
            else
                EmployeeContract.create_object(
                    :employee_id => params[:employee_id],
                    :start_date => params[:start_date],
                    :end_date => params[:end_date],
                    :no => params[:no],
                    :description => params[:description]
                  )
            end
        end
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.office_id = params[:office_id]
        self.no = params[:no]
        self.is_employee = params[:is_employee]
        self.length_of_contract = params[:length_of_contract]
        self.start_date = params[:start_date]
        self.end_date = params[:end_date]
        self.description = params[:description]
        
        if self.save
            object = EmployeeContract.where(
                    :employee_id => self.employee_id,
                    :no => self.no
                ).first

            object.update_object(
                    :employee_id => self.employee_id,
                    :start_date => self.start_date,
                    :end_date => self.end_date,
                    :no => self.no,
                    :description => self.description
                )
        end
        
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
        
        object = EmployeeContract.where(
                    :employee_id => self.employee_id,
                    :no => self.no
                ).first
        
        object.delete_object
    end
end
