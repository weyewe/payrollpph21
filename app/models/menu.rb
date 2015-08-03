class Menu < ActiveRecord::Base
    has_many :user_privileges
    
    validates_presence_of :code
    validates_presence_of :name
    
    validates_uniqueness_of :code
    
    #object.create_object
    def self.create_object( params ) 
        new_object = self.new
        
        new_object.code = params[:code]
        new_object.name = params[:name]
        new_object.description = params[:description]
        
        new_object.save
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.code = params[:code]
        self.name = params[:name]
        self.description = params[:description]
        
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
