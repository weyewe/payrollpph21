class Wage < ActiveRecord::Base
    belongs_to :employee
    belongs_to :pph21
    belongs_to :ptkp
    belongs_to :jamsostek
    
    validates_presence_of :effective_date
    validates_presence_of :pph21_id
    validates_presence_of :ptkp_id
    validates_presence_of :jamsostek_id
    validates_presence_of :employee_id
    
    validate :valid_employee_id
    validate :valid_pph21_id
    validate :valid_ptkp_id
    validate :valid_jamsostek_id
    validate :unique_effective_date
    
    def unique_effective_date
        return if not employee_id.present?
        
        past_data_list = Wage.where(
                :employee_id => self.employee_id,
                :effective_date => self.effective_date
            )
            
        if not self.persisted? and past_data_list.count != 0
            self.errors.add(:effective_date, "Effective date tidak boleh duplicate")
            return self
        elsif self.persisted? and past_data_list.count > 0 
            past_data = past_data_list.first 
            if past_data.id != self.id
                self.errors.add(:effective_date, "Effective date tidak boleh duplicate")
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
    
    def valid_pph21_id
        return if not pph21_id.present? 
        
        object = Pph21.find_by_id pph21_id 
        
        if object.nil?
            self.errors.add(:pph21_id, "Harus ada pph21 id")
            return self
        end
    end
    
    def valid_ptkp_id
        return if not ptkp_id.present? 
        
        object = Ptkp.find_by_id ptkp_id 
        
        if object.nil?
            self.errors.add(:ptkp_id, "Harus ada ptkp id")
            return self
        end
    end
    
    def valid_jamsostek_id
        return if not jamsostek_id.present? 
        
        object = Jamsostek.find_by_id jamsostek_id 
        
        if object.nil?
            self.errors.add(:jamsostek_id, "Harus ada jamsostek id")
            return self
        end
    end
    
    #object.create_object
    def self.create_object( params ) 
        new_object = self.new
        
        new_object.employee_id = params[:employee_id]
        new_object.effective_date = params[:effective_date]
        new_object.pph21_id = params[:pph21_id]
        new_object.ptkp_id = params[:ptkp_id]
        new_object.jamsostek_id = params[:jamsostek_id]
        new_object.is_daily_basic = params[:is_daily_basic]
        new_object.basic_salary = params[:basic_salary]
        new_object.is_daily_seniority = params[:is_daily_seniority]
        new_object.seniority_allowance = params[:seniority_allowance]
        new_object.is_daily_functional = params[:is_daily_functional]
        new_object.functional_allowance = params[:functional_allowance]
        new_object.is_daily_meal = params[:is_daily_meal]
        new_object.meal_allowance = params[:meal_allowance]
        new_object.is_daily_transport = params[:is_daily_transport]
        new_object.transport_allowance = params[:transport_allowance]
        new_object.is_daily_communication = params[:is_daily_communication]
        new_object.communication_allowance = params[:communication_allowance]
        new_object.is_daily_medical = params[:is_daily_medical]
        new_object.medical_allowance = params[:medical_allowance]
        new_object.is_cooperative_member = params[:is_cooperative_member]
        new_object.cooperative_dues = params[:cooperative_dues]
        
        new_object.save
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.employee_id = params[:employee_id]
        self.effective_date = params[:effective_date]
        self.pph21_id = params[:pph21_id]
        self.ptkp_id = params[:ptkp_id]
        self.jamsostek_id = params[:jamsostek_id]
        self.is_daily_basic = params[:is_daily_basic]
        self.basic_salary = params[:basic_salary]
        self.is_daily_seniority = params[:is_daily_seniority]
        self.seniority_allowance = params[:seniority_allowance]
        self.is_daily_functional = params[:is_daily_functional]
        self.functional_allowance = params[:functional_allowance]
        self.is_daily_meal = params[:is_daily_meal]
        self.meal_allowance = params[:meal_allowance]
        self.is_daily_transport = params[:is_daily_transport]
        self.transport_allowance = params[:transport_allowance]
        self.is_daily_communication = params[:is_daily_communication]
        self.communication_allowance = params[:communication_allowance]
        self.is_daily_medical = params[:is_daily_medical]
        self.medical_allowance = params[:medical_allowance]
        self.is_cooperative_member = params[:is_cooperative_member]
        self.cooperative_dues = params[:cooperative_dues]
        
        self.save
        
        return self 
    end
    
    #object.deleted_object
    def delete_object
        # object = Salary.where(:employee_id => some_employee_id, :branch_id => some_branch_id).order("id DESC").first
        # object.destroy
        
        # #Where with OR    
        # Salary.where{
        #     (is_deleted.eq false)  & 
        #         (
        #             (employee_id.eq some_employee_id ) | 
        #             (branch_id.eq some_brnach_iud)
        #         )
        #     }
        
        # #Query with join
        # Salary.joins(:employee).where{
        #     ( employee.office_id.eq some_office_id)
        # }
        
        # 1. delete if last salary data
        return if not employee_id.present?
        
        object = Wage.where(
                    :employee_id => self.employee_id
                    ).order("id DESC").first
        
        last_effective_date = object.effective_date
        
        if self.effective_date == last_effective_date
            self.destroy
        end
        
        # self.destroy 
    end
end
