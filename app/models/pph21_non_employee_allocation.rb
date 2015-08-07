class Pph21NonEmployeeAllocation < ActiveRecord::Base
    belongs_to :pph21_non_employee
    
    validates_presence_of :pph21_non_employee_id
    validates_presence_of :bruto_value
    
    #validates_uniqueness_of :code
    
    validate :valid_pph21_non_employee_id
    validate :bruto_value_must_grather_than_zero
    
    def valid_pph21_non_employee_id
        return if not pph21_non_employee_id.present? 
        
        object = Pph21NonEmployee.find_by_id pph21_non_employee_id 
        
        if object.nil?
            self.errors.add(:pph21_non_employee_id, "Harus ada non employee id")
            return self
        end
    end
    
    def bruto_value_must_grather_than_zero
        return if not bruto_value.present?
        
        if bruto_value <= 0
            self.errors.add(:bruto_value, "Tidak boleh lebih kecil dari 0")
            return self
        end
    end
    
    #object.create_object
    def self.create_object( params ) 
        new_object = self.new
        
        new_object.pph21_non_employee_id = params[:pph21_non_employee_id]
        new_object.bruto_value = params[:bruto_value]
        
        if new_object.save
            obj_preference = Preference.first
            
            current_pph_non_npwp_percentage = obj_preference.pph_non_npwp_percentage
            current_dpp_percentage = obj_preference.dpp_percentage
            current_pph21_id = obj_preference.pph21_id
            
            obj_non_employee = Pph21NonEmployee.where{
                (id.eq params[:pph21_non_employee_id])
            }.first
            
            current_npwp = obj_non_employee.npwp
            current_npwp_method = obj_non_employee.npwp_method
            
            new_dpp = params[:bruto_value] * (current_dpp_percentage / 100)
            
            #Get PPh21
            total_pph = 0
            prosen_pph = 0
            new_dpp_calculate = new_dpp
                
            #Mencari Tarif PPh21
            if (current_npwp_method != 3)
                Pph21Detail.where{
                    (pph21_id.eq current_pph21_id)
                }.each do |pph|
                    if (pph.is_up == false) #Hingga tak terbatas (is up)
                        if (new_dpp_calculate > pph.to_value)
                            prosen_pph = pph.percentage
                            
                            total_pph = total_pph + ((pph.percentage/100)*(pph.to_value-pph.from_value))
                            
                            new_dpp_calculate = new_dpp_calculate - (pph.to_value-pph.from_value)
                            
                            if (new_dpp_calculate < 0)
                                new_dpp_calculate = 0
                            end
                        else
                            if (new_dpp_calculate > 0)
                                prosen_pph = pph.percentage
                                
                                total_pph = total_pph + (pph.percentage/100*new_dpp_calculate)
                                
                                new_dpp_calculate = new_dpp_calculate - (pph.to_value-pph.from_value)
                            
                                if (new_dpp_calculate < 0)
                                    new_dpp_calculate = 0
                                end
                            else
                                total_pph = total_pph + 0
                            end
                        end
                    else
                        if (new_dpp_calculate > pph.from_value)
                            prosen_pph = pph.percentage
                            
                            total_pph = total_pph + ((pph.percentage/100) * (new_dpp_calculate - pph.from_value))
                        else
                            total_pph = total_pph + 0
                        end
                    end
                end
            else
                Pph21Detail.where{
                    (pph21_id.eq current_pph21_id)
                }.each do |pph|
                    new_pph_max = (pph.percentage / 100) * (pph.to_value - pph.from_value)
                    new_pph_batas_pkp = pph.to_value - ((pph.percentage / 100) * pph.to_value)
                    
                    if new_dpp_calculate < new_pph_batas_pkp
                        if (pph.from_value == 0)
                            prosen_pph = pph.percentage
                            
                            total_pph = (new_dpp_calculate - pph.from_value) * (pph.percentage / (100 - pph.percentage)) + pph.from_value
                            new_dpp_calculate = 0
                        else
                            if (new_dpp_calculate != 0)
                                prosen_pph = pph.percentage
                                
                                total_pph = (new_dpp_calculate - new_pph_batas_pkp) * (pph.percentage / (100 - pph.percentage)) + new_pph_max
                            end
                        end
                    else
                        total_pph = total_pph + 0
                    end
                end
            end
            total_pph = total_pph.round
            
            if (current_npwp == "")
                new_pph21_non_npwp = total_pph * (current_pph_non_npwp_percentage/100)
            else
                new_pph21_non_npwp = 0
            end
            
            #Get PPh21 after check NPWP
            new_pph21 = total_pph + new_pph21_non_npwp
            
            
            if (current_npwp_method == 3)
                new_tax_allowance = new_pph21
                new_dpp = new_dpp + (new_tax_allowance / 2) 
                new_dpp = new_dpp.round
            end
            
            new_object.dpp_value = new_dpp
            new_object.prosen_dpp = current_dpp_percentage
            new_object.prosen_pph = prosen_pph
            new_object.pph21_value = new_pph21
            
            new_object.save
        end
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.pph21_non_employee_id = params[:pph21_non_employee_id]
        self.bruto_value = params[:bruto_value]
        
        if self.save
            obj_preference = Preference.first
            
            current_pph_non_npwp_percentage = obj_preference.pph_non_npwp_percentage
            current_dpp_percentage = obj_preference.dpp_percentage
            current_pph21_id = obj_preference.pph21_id
            
            obj_non_employee = Pph21NonEmployee.where{
                (id.eq params[:pph21_non_employee_id])
            }.first
            
            current_npwp = obj_non_employee.npwp
            current_npwp_method = obj_non_employee.npwp_method
            
            new_dpp = params[:bruto_value] * (current_dpp_percentage / 100)
            
            #Get PPh21
            total_pph = 0
            prosen_pph = 0
            new_dpp_calculate = new_dpp
            
            #Mencari Tarif PPh21
            if (current_npwp_method != 3)
                Pph21Detail.where{
                    (pph21_id.eq current_pph21_id)
                }.each do |pph|
                    if (pph.is_up == false) #Hingga tak terbatas (is up)
                        if (new_dpp_calculate > pph.to_value)
                            prosen_pph = pph.percentage
                            
                            total_pph = total_pph + ((pph.percentage/100)*(pph.to_value-pph.from_value))
                            
                            new_dpp_calculate = new_dpp_calculate - (pph.to_value-pph.from_value)
                            
                            if (new_dpp_calculate < 0)
                                new_dpp_calculate = 0
                            end
                        else
                            if (new_dpp_calculate > 0)
                                prosen_pph = pph.percentage
                                
                                total_pph = total_pph + (pph.percentage/100*new_dpp_calculate)
                                
                                new_dpp_calculate = new_dpp_calculate - (pph.to_value-pph.from_value)
                            
                                if (new_dpp_calculate < 0)
                                    new_dpp_calculate = 0
                                end
                            else
                                total_pph = total_pph + 0
                            end
                        end
                    else
                        if (new_dpp_calculate > pph.from_value)
                            prosen_pph = pph.percentage
                            
                            total_pph = total_pph + ((pph.percentage/100) * (new_dpp_calculate - pph.from_value))
                        else
                            total_pph = total_pph + 0
                        end
                    end
                end
            else
                Pph21Detail.where{
                    (pph21_id.eq current_pph21_id)
                }.each do |pph|
                    new_pph_max = (pph.percentage / 100) * (pph.to_value - pph.from_value)
                    new_pph_batas_pkp = pph.to_value - ((pph.percentage / 100) * pph.to_value)
                    
                    if new_dpp_calculate < new_pph_batas_pkp
                        if (pph.from_value == 0)
                            prosen_pph = pph.percentage
                            
                            total_pph = (new_dpp_calculate - pph.from_value) * (pph.percentage / (100 - pph.percentage)) + pph.from_value
                            new_dpp_calculate = 0
                        else
                            if (new_dpp_calculate != 0)
                                prosen_pph = pph.percentage
                                
                                total_pph = (new_dpp_calculate - new_pph_batas_pkp) * (pph.percentage / (100 - pph.percentage)) + new_pph_max
                            end
                        end
                    else
                        total_pph = total_pph + 0
                    end
                end
            end
            total_pph = total_pph.round
            
            if (current_npwp == "")
                new_pph21_non_npwp = total_pph * (current_pph_non_npwp_percentage/100)
            else
                new_pph21_non_npwp = 0
            end
            
            #Get PPh21 after check NPWP
            new_pph21 = total_pph + new_pph21_non_npwp
            
            if (current_npwp_method == 3)
                new_tax_allowance = new_pph21
                new_dpp = new_dpp + (new_tax_allowance / 2) 
                new_dpp = new_dpp.round
            end
            
            self.dpp_value = new_dpp
            self.prosen_dpp = current_dpp_percentage
            self.prosen_pph = prosen_pph
            self.pph21_value = new_pph21
            
            self.save
        end
        
        return self 
    end
    
    #object.deleted_object
    def delete_object
        self.destroy
    end
end
