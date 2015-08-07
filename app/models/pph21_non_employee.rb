class Pph21NonEmployee < ActiveRecord::Base
    belongs_to :office
    
    has_many :pph21_non_employee_allocations
    
    validates_presence_of :nik
    validates_presence_of :name
    validates_presence_of :marital_status
    validates_presence_of :number_of_children
    validates_presence_of :npwp_method
    validates_presence_of :office_id
    validates_presence_of :tax_code_id
    
    #validates_uniqueness_of :code
    
    validate :valid_office_id
    validate :valid_tax_code_id
    validate :unique_nik
    
    def unique_nik
        return if not office_id.present? 
        
        past_data_list = Pph21NonEmployee.where(
                :office_id => self.office_id,
                :nik => self.nik
            )
            
        if not self.persisted? and past_data_list.count != 0
            self.errors.add(:nik, "NIK tidak boleh duplicate")
            return self
        elsif self.persisted? and past_data_list.count > 0 
            past_data = past_data_list.first 
            if past_data.id != self.id
                self.errors.add(:nik, "NIK tidak boleh duplicate")
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
        
        new_object.office_id = params[:office_id]
        new_object.nik = params[:nik]
        new_object.name = params[:name]
        new_object.address = params[:address]
        new_object.npwp = params[:npwp]
        new_object.marital_status = params[:marital_status]
        new_object.number_of_children = params[:number_of_children]
        new_object.tax_code_id = params[:tax_code_id]
        new_object.npwp_method = params[:npwp_method]
        
        new_object.save
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.office_id = params[:office_id]
        self.nik = params[:nik]
        self.name = params[:name]
        self.address = params[:address]
        self.npwp = params[:npwp]
        self.marital_status = params[:marital_status]
        self.number_of_children = params[:number_of_children]
        self.tax_code_id = params[:tax_code_id]
        self.npwp_method = params[:npwp_method]
        
        self.save
        
        return self 
    end
    
    #object.deleted_object
    def delete_object
        # 1. jika sudah ada pph21_non_employee_allocations, tidak boleh di delete
        if self.pph21_non_employee_allocations.count != 0 
            self.errors.add(:generic_errors, "sudah ada transaksi")
            return self 
        end
        
        self.destroy
    end
end
