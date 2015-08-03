class WageTransaction < ActiveRecord::Base
    belongs_to :employee
    
    validates_presence_of :employee_id
    validates_presence_of :month
    validates_presence_of :basic_salary
    validates_presence_of :seniority_allowance
    validates_presence_of :functional_allowance
    validates_presence_of :meal_allowance
    validates_presence_of :transport_allowance
    validates_presence_of :phone_allowance
    validates_presence_of :medical_allowance
    validates_presence_of :overtime
    validates_presence_of :pph21_allowance
    validates_presence_of :other_allowance_taxable
    validates_presence_of :other_allowance_non_taxable
    validates_presence_of :thr
    validates_presence_of :commission
    validates_presence_of :jkk
    validates_presence_of :jkm
    validates_presence_of :jht_company
    validates_presence_of :bpjs_company
    validates_presence_of :other_expense_taxable
    validates_presence_of :other_expense_non_taxable
    validates_presence_of :loan
    validates_presence_of :cooperative_dues
    validates_presence_of :jht_employee
    validates_presence_of :bpjs_employee
    validates_presence_of :pph21_value
    
    validate :valid_employee_id
    validate :valid_unique_month
    
    def valid_employee_id
        return if not employee_id.present? 
        
        object = Employee.find_by_id employee_id 
        
        if object.nil?
            self.errors.add(:employee_id, "Harus ada employee id")
            return self
        end
    end
    
    def valid_unique_month
        return if not employee_id.present?
        
        past_data_list = WageTransaction.where(
                :employee_id => self.employee_id,
                :month => self.month
            )
            
        if not self.persisted? and past_data_list.count != 0
            self.errors.add(:month, "tidak boleh duplicate")
            return self
        elsif self.persisted? and past_data_list.count > 0 
            past_data = past_data_list.first 
            if past_data.id != self.id
                self.errors.add(:month, "tidak boleh duplicate")
                return self 
            end
        end
    end
    
    #object.create_object
    def self.create_object( params ) 
        new_object = self.new
        
        new_object.employee_id = params[:employee_id]
        new_object.month = params[:month]
        new_object.basic_salary = params[:basic_salary]
        new_object.seniority_allowance = params[:seniority_allowance]
        new_object.functional_allowance = params[:functional_allowance]
        new_object.meal_allowance = params[:meal_allowance]
        new_object.transport_allowance = params[:transport_allowance]
        new_object.phone_allowance = params[:phone_allowance]
        new_object.medical_allowance = params[:medical_allowance]
        new_object.overtime = params[:overtime]
        new_object.pph21_allowance = params[:pph21_allowance]
        new_object.other_allowance_taxable = params[:other_allowance_taxable]
        new_object.other_allowance_non_taxable = params[:other_allowance_non_taxable]
        new_object.thr = params[:thr]
        new_object.commission = params[:commission]
        new_object.jkk = params[:jkk]
        new_object.jkm = params[:jkm]
        new_object.jht_company = params[:jht_company]
        new_object.bpjs_company = params[:bpjs_company]
        new_object.other_expense_taxable = params[:other_expense_taxable]
        new_object.other_expense_non_taxable = params[:other_expense_non_taxable]
        new_object.loan = params[:loan]
        new_object.cooperative_dues = params[:cooperative_dues]
        new_object.jht_employee = params[:jht_employee]
        new_object.bpjs_employee = params[:bpjs_employee]
        new_object.pph21_value = params[:pph21_value]
        
        new_object.save
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.employee_id = params[:employee_id]
        self.month = params[:month]
        self.basic_salary = params[:basic_salary]
        self.seniority_allowance = params[:seniority_allowance]
        self.functional_allowance = params[:functional_allowance]
        self.meal_allowance = params[:meal_allowance]
        self.transport_allowance = params[:transport_allowance]
        self.phone_allowance = params[:phone_allowance]
        self.medical_allowance = params[:medical_allowance]
        self.overtime = params[:overtime]
        self.pph21_allowance = params[:pph21_allowance]
        self.other_allowance_taxable = params[:other_allowance_taxable]
        self.other_allowance_non_taxable = params[:other_allowance_non_taxable]
        self.thr = params[:thr]
        self.commission = params[:commission]
        self.jkk = params[:jkk]
        self.jkm = params[:jkm]
        self.jht_company = params[:jht_company]
        self.bpjs_company = params[:bpjs_company]
        self.other_expense_taxable = params[:other_expense_taxable]
        self.other_expense_non_taxable = params[:other_expense_non_taxable]
        self.loan = params[:loan]
        self.cooperative_dues = params[:cooperative_dues]
        self.jht_employee = params[:jht_employee]
        self.bpjs_employee = params[:bpjs_employee]
        self.pph21_value = params[:pph21_value]
        
        self.save
        
        return self 
    end
    
    #object.deleted_object
    def delete_object
        self.destroy
    end
end
