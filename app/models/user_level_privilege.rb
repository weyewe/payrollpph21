class UserLevelPrivilege < ActiveRecord::Base
    belongs_to :user
    belongs_to :level
    
    validates_presence_of :user_id
    validates_presence_of :level_id
    validates_presence_of :is_allow
    
    #validates_uniqueness_of :code
    
    validate :valid_user_id
    validate :valid_level_id
    
    def valid_user_id
        return if not user_id.present? 
        
        object = User.find_by_id user_id 
        
        if object.nil?
            self.errors.add(:user_id, "Harus ada user id")
            return self
        end
    end
    
    def valid_level_id
        return if not level_id.present? 
        
        object = Level.find_by_id level_id 
        
        if object.nil?
            self.errors.add(:level_id, "Harus ada leve id")
            return self
        end
    end
    
    #object.create_object
    def self.create_object( params ) 
        new_object = self.new
        
        new_object.user_id = params[:user_id]
        new_object.level_id = params[:level_id]
        new_object.is_allow = params[:is_allow]
        
        new_object.save
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.user_id = params[:user_id]
        self.level_id = params[:level_id]
        self.is_allow = params[:is_allow]
        
        self.save
        
        return self 
    end
    
    #object.deleted_object
    def delete_object
        self.destroy 
    end
end
