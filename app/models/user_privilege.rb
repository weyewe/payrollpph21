class UserPrivilege < ActiveRecord::Base
    belongs_to :user
    belongs_to :menu
    
    validates_presence_of :user_id
    validates_presence_of :menu_id
    validates_presence_of :is_allow_read
    validates_presence_of :is_allow_add
    validates_presence_of :is_allow_edit
    validates_presence_of :is_allow_delete
    validates_presence_of :is_allow_print
    validates_presence_of :is_allow_approve
    
    #validates_uniqueness_of :code
    
    validate :valid_user_id
    validate :valid_menu_id
    
    def valid_user_id
        return if not user_id.present? 
        
        object = User.find_by_id user_id 
        
        if object.nil?
            self.errors.add(:user_id, "Harus ada user id")
            return self
        end
    end
    
    def valid_menu_id
        return if not menu_id.present? 
        
        object = Menu.find_by_id menu_id 
        
        if object.nil?
            self.errors.add(:menu_id, "Harus ada menu id")
            return self
        end
    end
    
    #object.create_object
    def self.create_object( params ) 
        new_object = self.new
        
        new_object.user_id = params[:user_id]
        new_object.menu_id = params[:menu_id]
        new_object.is_allow_read = params[:is_allow_read]
        new_object.is_allow_add = params[:is_allow_add]
        new_object.is_allow_edit = params[:is_allow_edit]
        new_object.is_allow_delete = params[:is_allow_delete]
        new_object.is_allow_print = params[:is_allow_print]
        new_object.is_allow_approve = params[:is_allow_approve]
        
        new_object.save
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.user_id = params[:user_id]
        self.menu_id = params[:menu_id]
        self.is_allow_read = params[:is_allow_read]
        self.is_allow_add = params[:is_allow_add]
        self.is_allow_edit = params[:is_allow_edit]
        self.is_allow_delete = params[:is_allow_delete]
        self.is_allow_print = params[:is_allow_print]
        self.is_allow_approve = params[:is_allow_approve]
        
        self.save
        
        return self 
    end
    
    #object.deleted_object
    def delete_object
        self.destroy 
    end
end
