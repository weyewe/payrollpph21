class User < ActiveRecord::Base
    belongs_to :office
    has_many :user_privileges
    
    validates_presence_of :username
    validates_presence_of :password
    validates_presence_of :name
    validates_presence_of :office_id
    
    #validates_uniqueness_of :code
    
    validate :valid_office_id
    validate :unique_username
    
    def unique_username
        return if not office_id.present? 
        
        past_data_list = User.where(
                :office_id => self.office_id,
                :username => self.username
            )
            
        if not self.persisted? and past_data_list.count != 0
            self.errors.add(:username, "Username tidak boleh duplicate")
            return self
        elsif self.persisted? and past_data_list.count > 0 
            past_data = past_data_list.first 
            if past_data.id != self.id
                self.errors.add(:username, "Username tidak boleh duplicate")
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
        new_object.username = params[:username]
        new_object.password = params[:password]
        new_object.name = params[:name]
        
        new_object.save
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.office_id = params[:office_id]
        self.username = params[:username]
        self.password = params[:password]
        self.name = params[:name]
        
        self.save
        
        return self 
    end
    
    #object.deleted_object
    def delete_object
        # 1. jika sudah ada user privilege, tidak boleh di delete
        if self.user_privileges.count != 0 
            self.errors.add(:generic_errors, "sudah ada user privilege")
            return self 
        end
        
        self.destroy 
    end
end
