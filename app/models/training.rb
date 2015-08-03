class Training < ActiveRecord::Base
    has_many :employees
    has_many :training_details
    
    validates_presence_of :subject
    validates_presence_of :start_date
    validates_presence_of :end_date
    validates_presence_of :office_id
    
    #validates_uniqueness_of :code
    
    validate :valid_office_id
    
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
        new_object.subject = params[:subject]
        new_object.start_date = params[:start_date]
        new_object.end_date = params[:end_date]
        new_object.trainer = params[:trainer]
        new_object.location = params[:location]
        new_object.description = params[:description]
        
        new_object.save
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.office_id = params[:office_id]
        self.subject = params[:subject]
        self.start_date = params[:start_date]
        self.end_date = params[:end_date]
        self.trainer = params[:trainer]
        self.location = params[:location]
        self.description = params[:description]
        
        self.save
        
        return self 
    end
    
    #object.deleted_object
    def delete_object
        # 1. jika sudah ada employee, tidak boleh di delete
        if self.training_details.count != 0 
            self.errors.add(:generic_errors, "sudah ada detail")
            return self 
        end
        
        self.destroy 
    end
end
