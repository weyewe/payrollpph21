class Pph21Detail < ActiveRecord::Base
    belongs_to :pph21
    
    validates_presence_of :percentage
    validates_presence_of :from_value
    validates_presence_of :to_value
    validates_presence_of :pph21_id
    
    validate :valid_pph21_id
    validate :unique_percentage
    
    def valid_pph21_id
        return if not pph21_id.present? 
        
        object = Pph21.find_by_id pph21_id 
        
        if object.nil?
            self.errors.add(:pph21_id, "Harus ada pph id")
            return self
        end
    end
    
    def unique_percentage
        return if not pph21_id.present? 
        
        past_data_list = Pph21Detail.where(
                :pph21_id => self.pph21_id,
                :percentage => self.percentage
            )
            
        if not self.persisted? and past_data_list.count != 0
            self.errors.add(:percentage, "Percentage tidak boleh duplicate")
            return self
        elsif self.persisted? and past_data_list.count > 0 
            past_data = past_data_list.first 
            if past_data.id != self.id
                self.errors.add(:percentage, "Percentage tidak boleh duplicate")
                return self 
            end
        end
    end
    
    #object.create_object
    def self.create_object( params ) 
        new_object = self.new
        
        new_object.pph21_id = params[:pph21_id]
        new_object.percentage = params[:percentage]
        new_object.from_value = params[:from_value]
        new_object.to_value = params[:to_value]
        new_object.is_up = params[:is_up]
        new_object.description = params[:description]
        
        new_object.save
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.pph21_id = params[:pph21_id]
        self.percentage = params[:percentage]
        self.from_value = params[:from_value]
        self.to_value = params[:to_value]
        self.is_up = params[:is_up]
        self.description = params[:description]
        
        self.save
        
        return self 
    end
    
    #object.deleted_object
    def delete_object
        self.destroy 
    end
end
