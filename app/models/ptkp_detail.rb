class PtkpDetail < ActiveRecord::Base
    belongs_to :ptkp
    
    validates_presence_of :marital_status
    validates_presence_of :number_of_children
    validates_presence_of :value
    validates_presence_of :ptkp_id
    
    validate :valid_ptkp_id
    validate :unique_marital_status_and_number_of_children
    validate :valid_zero_value
    
    def valid_ptkp_id
        return if not ptkp_id.present? 
        
        object = Ptkp.find_by_id ptkp_id 
        
        if object.nil?
            self.errors.add(:ptkp_id, "Harus ada ptkp id")
            return self
        end
    end
    
    def unique_marital_status_and_number_of_children
        return if not ptkp_id.present?
        
        past_data_list = PtkpDetail.where(
                :ptkp_id => self.ptkp_id,
                :marital_status => self.marital_status,
                :number_of_children => self.number_of_children
            )
            
        if not self.persisted? and past_data_list.count != 0
            self.errors.add(:marital_status, "Marital status dan number of children tidak boleh duplicate")
            self.errors.add(:number_of_children, "Marital status dan number of children tidak boleh duplicate")
            return self
        elsif self.persisted? and past_data_list.count > 0 
            past_data = past_data_list.first 
            if past_data.id != self.id
                self.errors.add(:marital_status, "Marital status dan number of children tidak boleh duplicate")
                self.errors.add(:number_of_children, "Marital status dan number of children tidak boleh duplicate")
                return self 
            end
        end
        
    end
    
    def valid_zero_value
        return if not value.present?
        
        if value <= 0
           self.errors.add(:value, "Value harus lebih besar dari 0")
           return self 
        end
    end
    
    #object.create_object
    def self.create_object( params ) 
        new_object = self.new
        
        new_object.ptkp_id = params[:ptkp_id]
        new_object.marital_status = params[:marital_status]
        new_object.number_of_children = params[:number_of_children]
        new_object.value = params[:value]
        new_object.description = params[:description]
        
        new_object.save
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.ptkp_id = params[:ptkp_id]
        self.marital_status = params[:marital_status]
        self.number_of_children = params[:number_of_children]
        self.value = params[:value]
        self.description = params[:description]
        
        self.save
        
        return self 
    end
    
    #object.deleted_object
    def delete_object
        self.destroy 
    end
end
