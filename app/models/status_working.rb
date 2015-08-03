class StatusWorking < ActiveRecord::Base
    belongs_to :office
    has_many :employees
    has_many :recruitments
    
    validates_presence_of :code
    validates_presence_of :name
    validates_presence_of :office_id
    
    validate :valid_office_id
    validate :unique_code
    
    def unique_code
        return if not office_id.present? 
        
        past_data_list = StatusWorking.where(
                :office_id => self.office_id,
                :code => self.code
            )
            
        if not self.persisted? and past_data_list.count != 0
            self.errors.add(:code, "Code tidak boleh duplicate")
            return self
        elsif self.persisted? and past_data_list.count > 0 
            past_data = past_data_list.first 
            if past_data.id != self.id
                self.errors.add(:code, "Code tidak boleh duplicate")
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
        new_object.code = params[:code]
        new_object.name = params[:name]
        new_object.is_contract = params[:is_contract]
        new_object.description = params[:description]
        
        new_object.save
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.office_id = params[:office_id]
        self.code = params[:code]
        self.name = params[:name]
        self.is_contract = params[:is_contract]
        self.description = params[:description]
        
        self.save
        
        return self 
    end
    
    #object.deleted_object
    def delete_object
        # 1. jika sudah ada division, tidak boleh di delete
        if self.employees.count != 0 
            self.errors.add(:generic_errors, "sudah ada employee")
            return self 
        end
        
        self.destroy 
    end
end
