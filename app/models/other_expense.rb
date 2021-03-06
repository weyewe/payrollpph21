class OtherExpense < ActiveRecord::Base
    belongs_to :employee
    
    validates_presence_of :date
    validates_presence_of :value
    validates_presence_of :employee_id
    
    #validates_uniqueness_of :code
    
    validate :valid_employee_id
    validate :unique_date
    validate :valid_value_must_be_grather_than_zero
    
    def unique_date
        return if not employee_id.present?
        
        past_data_list = OtherIncome.where(
                :employee_id => self.employee_id,
                :date => self.date,
                :is_deleted => false
            )
            
        if not self.persisted? and past_data_list.count != 0
            self.errors.add(:date, "tidak boleh duplicate")
            return self
        elsif self.persisted? and past_data_list.count > 0 
            past_data = past_data_list.first 
            if past_data.id != self.id
                self.errors.add(:date, "tidak boleh duplicate")
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
    
    def valid_value_must_be_grather_than_zero
        return if not value.present?
        
        if value <= 0
            self.errors.add(:value, "Harus lebih besar dari 0")
            return self
        end
    end
    
    #object.create_object
    def self.create_object( params ) 
        new_object = self.new
        
        new_object.employee_id = params[:employee_id]
        new_object.date = params[:date]
        new_object.is_taxable = params[:is_taxable]
        new_object.value = BigDecimal(params[:value] || '0')
        new_object.description = params[:description]
        
        new_object.save
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.employee_id = params[:employee_id]
        self.date = params[:date]
        self.is_taxable = params[:is_taxable]
        self.value = BigDecimal(params[:value] || '0')
        self.description = params[:description]
        
        self.save
        
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
    end
end
