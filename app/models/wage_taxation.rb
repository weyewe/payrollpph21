class WageTaxation < ActiveRecord::Base
    belongs_to :employee
    belongs_to :tax_code
    
    validates_presence_of :effective_date
    validates_presence_of :tax_code_id
    validates_presence_of :employee_id
    validates_presence_of :marital_status
    validates_presence_of :number_of_children
    validates_presence_of :tax_method
    
    validate :valid_employee_id
    validate :valid_tax_code_id
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
    
    def valid_tax_code_id
        return if not tax_code_id.present? 
        
        object = TaxCode.find_by_id tax_code_id 
        
        if object.nil?
            self.errors.add(:tax_code_id, "Harus ada tax code id")
            return self
        end
    end
    
    #object.create_object
    def self.create_object( params ) 
        new_object = self.new
      
        new_object.employee_id = params[:employee_id]
        new_object.effective_date = params[:effective_date]
        new_object.marital_status = params[:marital_status]
        new_object.number_of_children = params[:number_of_children]
        new_object.tax_method = params[:tax_method]
        new_object.tax_code_id = params[:tax_code_id]
        new_object.npwp = params[:npwp]
        new_object.npwp_registered_date = params[:npwp_registered_date]
        new_object.npwp_address = params[:npwp_address]
        
        new_object.save
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.employee_id = params[:employee_id]
        self.effective_date = params[:effective_date]
        self.marital_status = params[:marital_status]
        self.number_of_children = params[:number_of_children]
        self.tax_method = params[:tax_method]
        self.tax_code_id = params[:tax_code_id]
        self.npwp = params[:npwp]
        self.npwp_registered_date = params[:npwp_registered_date]
        self.npwp_address = params[:npwp_address]
        
        self.save
        
        return self 
    end
    
    #object.deleted_object
    def delete_object
        return if not employee_id.present?
        
        object = WageTaxation.where(
                    :employee_id => self.employee_id
                    ).order("id DESC").first
        
        last_effective_date = object.effective_date
        
        if self.effective_date == last_effective_date
            self.destroy
        end
        
        # self.destroy 
    end
end
