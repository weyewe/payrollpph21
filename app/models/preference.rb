class Preference < ActiveRecord::Base
    belongs_to :office
    
    validates_presence_of :ot_divider
    validates_presence_of :biaya_jabatan_percentage
    validates_presence_of :biaya_jabatan_max
    validates_presence_of :pph_non_npwp_percentage
    validates_presence_of :dpp_percentage
    validates_presence_of :pph21_id
    validates_presence_of :office_id
    
    #validates_uniqueness_of :code
    
    validate :valid_office_id
    validate :unique_office
    validate :valid_ot_divider_must_greather_than_zero
    validate :valid_pph21_id
    
    def unique_office
        return if not office_id.present? 
        
        past_data_list = Preference.where(
                :office_id => self.office_id
            )
            
        if not self.persisted? and past_data_list.count != 0
            self.errors.add(:office_id, "tidak boleh duplicate")
            return self
        elsif self.persisted? and past_data_list.count > 0 
            past_data = past_data_list.first 
            if past_data.id != self.id
                self.errors.add(:office_id, "tidak boleh duplicate")
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
    
    def valid_ot_divider_must_greather_than_zero
        return if not ot_divider.present?
        
        if ot_divider <= 0
            self.errors.add(:ot_divider, "Tidak boleh lebih kecil sama dengan 0")
            return self
        end
    end
    
    def valid_pph21_id
        return if not pph21_id.present? 
        
        object = Pph21.find_by_id pph21_id 
        
        if object.nil?
            self.errors.add(:pph21_id, "Harus ada pph non employee id")
            return self
        end
    end
    
    #object.create_object
    def self.create_object( params ) 
        new_object = self.new
        
        new_object.office_id = params[:office_id]
        new_object.ot_divider = params[:ot_divider]
        new_object.biaya_jabatan_percentage = params[:biaya_jabatan_percentage]
        new_object.biaya_jabatan_max = params[:biaya_jabatan_max]
        new_object.pph_non_npwp_percentage = params[:pph_non_npwp_percentage]
        new_object.dpp_percentage = params[:dpp_percentage]
        new_object.pph21_id = params[:pph21_id]
        
        new_object.save
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.office_id = params[:office_id]
        self.ot_divider = params[:ot_divider]
        self.biaya_jabatan_percentage = params[:biaya_jabatan_percentage]
        self.biaya_jabatan_max = params[:biaya_jabatan_max]
        self.pph_non_npwp_percentage = params[:pph_non_npwp_percentage]
        self.dpp_percentage = params[:dpp_percentage]
        self.pph21_id = params[:pph21_id]
        
        self.save
        
        return self 
    end
    
    #object.deleted_object
    def delete_object
        self.destroy 
    end
end
