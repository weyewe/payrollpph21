class Termination < ActiveRecord::Base
    belongs_to :employee
    
    validates_presence_of :date
    validates_presence_of :description
    validates_presence_of :employee_id
    
    #validates_uniqueness_of :code
    
    validate :valid_employee_id
    validate :unique_date
    
    def unique_date
        return if not employee_id.present?
        
        past_data_list = Termination.where(
                :employee_id => self.employee_id,
                :date => self.date,
                :is_deleted => false
            )
            
        if not self.persisted? and past_data_list.count != 0
            self.errors.add(:date, "tidak boleh duplicate")
            return self
        elsif self.persisted? and past_data_list.count > 0 
            past_data = past_data_list.first 
            if past_data.id != self.id
                self.errors.add(:date, "tidak boleh duplicate")
                return self 
            end
        end
    end
    
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
        new_object.date = params[:date]
        new_object.description = params[:description]
        
        new_object.save
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.employee_id = params[:employee_id]
        self.date = params[:date]
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
        
        if self.is_approved
            self.errors.add(:generic_errors, "Sudah di approve")
            return self
        end
        
        self.is_deleted = true
        self.deleted_at = DateTime.now 
        self.save 
    end
    
    #object.approve_object
    def approve_object
        if self.is_approved
            self.errors.add(:generic_errors, "Sudah di approve")
            return self
        end
        
        object = Employee.where(
                :id => self.employee_id
            ).first
        
        object.is_not_active = true
        object.not_active_at = self.date
        object.save
        
        self.is_approved = true
        self.approved_at = DateTime.now 
        self.save 
    end
    
    #object.unapprove_object
    def unapprove_object
        if not self.is_approved
            self.errors.add(:generic_errors, "Sudah di unapprove")
            return self
        end
        
        object = Employee.where(
                :id => self.employee_id
            ).first
        
        object.is_not_active = false
        object.not_active_at = nil
        object.save
        
        self.is_approved = false
        self.approved_at = nil
        self.save 
    end
end
