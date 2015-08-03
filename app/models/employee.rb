class Employee < ActiveRecord::Base
    belongs_to :division
    belongs_to :title
    belongs_to :level
    belongs_to :status_working
    
    has_many :shift_allocations
    has_many :employee_relationships
    has_many :employee_educations
    has_many :employee_skills
    has_many :employee_job_experiences
    has_many :employee_offices
    has_many :employee_trainings
    has_many :employee_contracts
    has_many :attendances
    has_many :pkwts
    has_many :pkwtts
    has_many :certificates
    has_many :decrees
    has_many :training_details
    has_many :jobs
    has_many :private_leaves
    has_many :overtime_allocations
    has_many :leaves
    has_many :loans
    has_many :other_incomes
    has_many :other_expenses
    has_many :thrs
    has_many :commissions
    
    validates_presence_of :code
    validates_presence_of :full_name
    validates_presence_of :nick_name
    validates_presence_of :enroll_id
    validates_presence_of :office_id
    validates_presence_of :branch_office_id
    validates_presence_of :department_id
    validates_presence_of :division_id
    validates_presence_of :title_id
    validates_presence_of :level_id
    validates_presence_of :status_working_id
    validates_presence_of :bank_id
    
    validate :valid_office_id
    validate :valid_branch_office_id
    validate :valid_department_id
    validate :valid_division_id
    validate :valid_title_id
    validate :valid_level_id
    validate :valid_status_working_id
    validate :valid_bank_id
    validate :unique_code
    validate :unique_enroll_id
    
    def unique_code
        return if not office_id.present? 
        
        past_data_list = Employee.where(
                :office_id => self.office_id,
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
    
    def unique_enroll_id
        return if not office_id.present? 
        
        past_data_list = Employee.where(
                :office_id => self.office_id,
                :enroll_id => self.enroll_id
            )
            
        if not self.persisted? and past_data_list.count != 0
            self.errors.add(:enroll_id, "Enroll id tidak boleh duplicate")
            return self
        elsif self.persisted? and past_data_list.count > 0 
            past_data = past_data_list.first 
            if past_data.id != self.id
                self.errors.add(:enroll_id, "Enroll id tidak boleh duplicate")
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
    
    def valid_bank_id
        return if not bank_id.present? 
        
        object = Bank.find_by_id bank_id 
        
        if object.nil?
            self.errors.add(:bank_id, "Harus ada bank id")
            return self
        end
    end
    
    def self.create_object( params ) 
        
        new_object = self.new  # new_object = Employee.new
        
        new_object.office_id = params[:office_id]
        new_object.branch_office_id = params[:branch_office_id]
        new_object.department_id = params[:department_id]
        new_object.division_id = params[:division_id]
        new_object.title_id = params[:title_id]
        new_object.level_id = params[:level_id]
        new_object.status_working_id = params[:status_working_id]
        new_object.code = params[:code]
        new_object.full_name = params[:full_name]
        new_object.nick_name = params[:nick_name]
        new_object.enroll_id = params[:enroll_id]
        new_object.place_of_birth = params[:place_of_birth]
        new_object.date_of_birth = params[:date_of_birth]
        new_object.gender = params[:gender]
        new_object.religion = params[:religion]
        new_object.address = params[:address]
        new_object.no_jamsostek = params[:no_jamsostek]
        new_object.jamsostek_registered_date = params[:jamsostek_registered_date]
        new_object.bank_id = params[:bank_id]
        new_object.bank_account = params[:bank_account]
        new_object.bank_account_name = params[:bank_account_name]
        new_object.start_working = params[:start_working]
        new_object.phone = params[:phone]
        new_object.hp = params[:hp]
        new_object.email = params[:email]
        new_object.country = params[:country]
        new_object.identity_number = params[:identity_number]
        # new_object.is_not_active = params[:is_not_active]
        # new_object.not_active_on = params[:not_active_on]
        new_object.description = params[:description]
        
        if new_object.save
            EmployeeOffice.create_object(
                    :employee_id => new_object.id,
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
        
        self.office_id = params[:office_id]
        self.branch_office_id = params[:branch_office_id]
        self.department_id = params[:department_id]
        self.division_id = params[:division_id]
        self.title_id = params[:title_id]
        self.level_id = params[:level_id]
        self.status_working_id = params[:status_working_id]
        self.code = params[:code]
        self.full_name = params[:full_name]
        self.nick_name = params[:nick_name]
        self.enroll_id = params[:enroll_id]
        self.place_of_birth = params[:place_of_birth]
        self.date_of_birth = params[:date_of_birth]
        self.gender = params[:gender]
        self.religion = params[:religion]
        self.address = params[:address]
        self.no_jamsostek = params[:no_jamsostek]
        self.jamsostek_registered_date = params[:jamsostek_registered_date]
        self.bank_id = params[:bank_id]
        self.bank_account = params[:bank_account]
        self.bank_account_name = params[:bank_account_name]
        self.start_working = params[:start_working]
        self.phone = params[:phone]
        self.hp = params[:hp]
        self.email = params[:email]
        self.country = params[:country]
        self.identity_number = params[:identity_number]
        # self.is_not_active = params[:is_not_active]
        # self.not_active_on = params[:not_active_on]
        self.description = params[:description]
        
        if self.save
            if current_office_id != self.office_id or 
                current_branch_office_id != self.branch_office_id or 
                current_department_id != self.department_id or 
                current_division_id != self.division_id or 
                current_title_id != self.title_id
                
            EmployeeOffice.create_object(
                    :employee_id => self.id,
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
        # 1. jika sudah ada attendance, tidak boleh di delete
        if self.attendances.count != 0 
            self.errors.add(:generic_errors, "sudah ada attendance")
            return self 
        end
        
        # 2. jika sudah ada employee_relationships, tidak boleh di delete
        if self.employee_relationships.count != 0 
            self.errors.add(:generic_errors, "sudah ada employee_relationships")
            return self 
        end
        
        # 3. jika sudah ada employee_educations, tidak boleh di delete
        if self.employee_educations.count != 0 
            self.errors.add(:generic_errors, "sudah ada employee_educations")
            return self 
        end
        
        # 4. jika sudah ada employee_skills, tidak boleh di delete
        if self.employee_skills.count != 0 
            self.errors.add(:generic_errors, "sudah ada employee_skills")
            return self 
        end
        
        # 5. jika sudah ada employee_job_experiences, tidak boleh di delete
        if self.employee_job_experiences.count != 0 
            self.errors.add(:generic_errors, "sudah ada employee_job_experiences")
            return self 
        end
        
        # 6. jika sudah ada employee_trainings, tidak boleh di delete
        if self.employee_trainings.count != 0 
            self.errors.add(:generic_errors, "sudah ada employee_trainings")
            return self 
        end
        
        # 7. jika sudah ada employee_contracts, tidak boleh di delete
        if self.employee_contracts.count != 0 
            self.errors.add(:generic_errors, "sudah ada employee_contracts")
            return self 
        end
        
        # 8. jika sudah ada decrees, tidak boleh di delete
        if self.decrees.count != 0 
            self.errors.add(:generic_errors, "sudah ada decrees")
            return self 
        end
        
        # 9. jika sudah ada shift_allocations, tidak boleh di delete
        if self.shift_allocations.count != 0 
            self.errors.add(:generic_errors, "sudah ada shift_allocations")
            return self 
        end
        
        # 10. jika sudah ada pkwts, tidak boleh di delete
        if self.pkwts.count != 0 
            self.errors.add(:generic_errors, "sudah ada pkwts")
            return self 
        end
        
        # 11. jika sudah ada pkwtts, tidak boleh di delete
        if self.pkwtts.count != 0 
            self.errors.add(:generic_errors, "sudah ada pkwtts")
            return self 
        end
        
        # 12. jika sudah ada training_details, tidak boleh di delete
        if self.training_details.count != 0 
            self.errors.add(:generic_errors, "sudah ada training_details")
            return self 
        end
        
        # 12. jika sudah ada jobs, tidak boleh di delete
        if self.jobs.count != 0 
            self.errors.add(:generic_errors, "sudah ada jobs")
            return self 
        end
        
        # # 13. jika sudah ada private_leaves, tidak boleh di delete
        # if self.private_leaves.count != 0 
        #     self.errors.add(:generic_errors, "sudah ada private_leaves")
        #     return self 
        # end
        
        # 14. jika sudah ada overtime_allocations, tidak boleh di delete
        if self.overtime_allocations.count != 0 
            self.errors.add(:generic_errors, "sudah ada overtime_allocations")
            return self 
        end
        
        # # 15. jika sudah ada leaves, tidak boleh di delete
        # if self.leaves.count != 0 
        #     self.errors.add(:generic_errors, "sudah ada leaves")
        #     return self 
        # end
        
        # 16. jika sudah ada loans, tidak boleh di delete
        if self.loans.count != 0 
            self.errors.add(:generic_errors, "sudah ada loans")
            return self 
        end
        
        # 17. jika sudah ada other_incomes, tidak boleh di delete
        if self.other_incomes.count != 0 
            self.errors.add(:generic_errors, "sudah ada other_incomes")
            return self 
        end
        
        # 18. jika sudah ada other_expenses, tidak boleh di delete
        if self.other_expenses.count != 0 
            self.errors.add(:generic_errors, "sudah ada other_expenses")
            return self 
        end
        
        # 19. jika sudah ada thrs, tidak boleh di delete
        if self.thrs.count != 0 
            self.errors.add(:generic_errors, "sudah ada thrs")
            return self 
        end
        
        # 20. jika sudah ada commissions, tidak boleh di delete
        if self.commissions.count != 0 
            self.errors.add(:generic_errors, "sudah ada commissions")
            return self 
        end
        
        self.destroy 
    end
    
    # Employee.create() 
    # employee.update() 
    # employee.destroy
end
