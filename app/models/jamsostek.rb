class Jamsostek < ActiveRecord::Base
    belongs_to :office
    has_many :wages
    
    validates_presence_of :code
    validates_presence_of :name
    validates_presence_of :jkk_percentage
    validates_presence_of :jkm_percentage
    validates_presence_of :jht_employee_percentage
    validates_presence_of :jht_office_percentage
    validates_presence_of :office_id
    
    validate :valid_office_id
    validate :valid_zero_jkk_percentage
    validate :valid_zero_jkm_percentage
    validate :valid_zero_jht_employee_percentage
    validate :valid_zero_jht_office_percentage
    validate :unique_code
    
    def unique_code
        return if not office_id.present? 
        
        past_data_list = Jamsostek.where(
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
    
    def valid_office_id
        return if not office_id.present? 
        
        object = Office.find_by_id office_id 
        
        if object.nil?
            self.errors.add(:office_id, "Harus ada office id")
            return self
        end
    end
    
    def valid_zero_jkk_percentage
        return if not jkk_percentage.present?
        
        if jkk_percentage <= 0
            self.errors.add(:jkk_percentage, "JKK Percentage harus lebih besar dari 0")
            return self
        end
    end
    
    def valid_zero_jkm_percentage
        return if not jkm_percentage.present?
        
        if jkm_percentage <= 0
            self.errors.add(:jkm_percentage, "JKM Percentage harus lebih besar dari 0")
            return self
        end
    end
    
    def valid_zero_jht_employee_percentage
        return if not jht_employee_percentage.present?
        
        if jht_employee_percentage <= 0
            self.errors.add(:jht_employee_percentage, "JHT Employee Percentage harus lebih besar dari 0")
            return self
        end
    end
    
    def valid_zero_jht_office_percentage
        return if not jht_office_percentage.present?
        
        if jht_office_percentage <= 0
            self.errors.add(:jht_office_percentage, "JHT Office Percentage harus lebih besar dari 0")
            return self
        end
    end
    
    #object.create_object
    def self.create_object( params ) 
        new_object = self.new
        
        new_object.office_id = params[:office_id]
        new_object.code = params[:code]
        new_object.name = params[:name]
        new_object.jkk_percentage = params[:jkk_percentage]
        new_object.jkm_percentage = params[:jkm_percentage]
        new_object.jht_employee_percentage = params[:jht_employee_percentage]
        new_object.jht_office_percentage = params[:jht_office_percentage]
        
        new_object.save
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.office_id = params[:office_id]
        self.code = params[:code]
        self.name = params[:name]
        self.jkk_percentage = params[:jkk_percentage]
        self.jkm_percentage = params[:jkm_percentage]
        self.jht_employee_percentage = params[:jht_employee_percentage]
        self.jht_office_percentage = params[:jht_office_percentage]
        
        self.save
        
        return self 
    end
    
    #object.deleted_object
    def delete_object
        # 1. jika sudah ada salary tax, tidak boleh di delete
        if self.wages.count != 0 
            self.errors.add(:generic_errors, "sudah ada salary tax")
            return self 
        end
        
        self.destroy 
    end
end
