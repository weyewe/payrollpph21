class BpjsPercentage < ActiveRecord::Base
    belongs_to :office
    
    has_many :bpjs_insurances
    
    validates_presence_of :employee_percentage
    validates_presence_of :office_percentage
    validates_presence_of :max_of_children
    validates_presence_of :office_id
    
    #validates_uniqueness_of :code
    
    validate :valid_office_id
    validate :unique_office_id
    
    def unique_office_id
        return if not office_id.present? 
        
        past_data_list = BpjsPercentage.where(
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
    
    #object.create_object
    def self.create_object( params ) 
        new_object = self.new
        
        new_object.office_id = params[:office_id]
        new_object.employee_percentage = params[:employee_percentage]
        new_object.office_percentage = params[:office_percentage]
        new_object.max_of_children = params[:max_of_children]
        
        new_object.save
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.office_id = params[:office_id]
        self.employee_percentage = params[:employee_percentage]
        self.office_percentage = params[:office_percentage]
        self.max_of_children = params[:max_of_children]
        
        self.save
        
        return self 
    end
    
    #object.deleted_object
    def delete_object
        self.destroy 
    end
end
