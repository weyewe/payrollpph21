class Device < ActiveRecord::Base
    belongs_to :office
    
    validates_presence_of :ip_address
    validates_presence_of :port
    validates_presence_of :name
    validates_presence_of :office_id
    
    validate :valid_office_id
    validate :unique_ip_address
    
    def unique_ip_address
        return if not office_id.present? 
        
        past_data_list = Device.where(
                :office_id => self.office_id,
                :ip_address => self.ip_address
            )
            
        if not self.persisted? and past_data_list.count != 0
            self.errors.add(:ip_address, "IP address tidak boleh duplicate")
            return self
        elsif self.persisted? and past_data_list.count > 0 
            past_data = past_data_list.first 
            if past_data.id != self.id
                self.errors.add(:ip_address, "IP address tidak boleh duplicate")
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
    
    #object.create_object
    def self.create_object( params ) 
        new_object = self.new
        
        new_object.office_id = params[:office_id]
        new_object.ip_address = params[:ip_address]
        new_object.port = params[:port]
        new_object.name = params[:name]
        
        new_object.save
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.office_id = params[:office_id]
        self.ip_address = params[:ip_address]
        self.port = params[:port]
        self.name = params[:name]
        
        self.save
        
        return self 
    end
    
    #object.deleted_object
    def delete_object
        self.destroy 
    end
end
