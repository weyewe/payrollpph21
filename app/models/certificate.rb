class Certificate < ActiveRecord::Base
    belongs_to :employee
    
    validates_presence_of :employee_id
    validates_presence_of :received_at
    validates_presence_of :no_certificate
    validates_presence_of :receiver
    
    #validates_uniqueness_of :code
    
    validate :valid_employee_id
    
    def valid_employee_id
        return if not employee_id.present? 
        
        object = Employee.find_by_id employee_id 
        
        if object.nil?
            self.errors.add(:employee_id, "Harus ada employee id")
            return self
        end
    end
    
    #object.create_object
    def self.create_object( params ) 
        new_object = self.new
      
        new_object.employee_id = params[:employee_id]
        new_object.received_at = params[:received_at]
        new_object.location = params[:location]
        new_object.no_certificate = params[:no_certificate]
        new_object.receiver = params[:receiver]
        new_object.is_returned = params[:is_returned]
        new_object.returned_at = params[:returned_at]
        new_object.giver = params[:giver]
        new_object.description = params[:description]
        
        new_object.save
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.employee_id = params[:employee_id]
        self.received_at = params[:received_at]
        self.location = params[:location]
        self.no_certificate = params[:no_certificate]
        self.receiver = params[:receiver]
        self.is_returned = params[:is_returned]
        self.returned_at = params[:returned_at]
        self.giver = params[:giver]
        self.description = params[:description]
        
        self.save
        
        return self 
    end
    
    #object.deleted_object
    def delete_object
        if self.is_deleted
            self.errors.add(:generic_errors, "Sudah di delete")
            return self
        end
        
        self.is_deleted = true
        self.deleted_at = DateTime.now 
        
        self.save
    end
    
    #object.returned_certificate
    def returned_certificate( params )
        if self.is_returned
            self.errors.add(:generic_errors, "Sudah dikembalikan")
            return self
        end
        
        self.is_returned = true
        self.returned_at = params[:returned_at]
        self.giver = params[:giver]
        
        self.save
        
        return self
    end
end
