class EmployeeTraining < ActiveRecord::Base
    belongs_to :employee
    
    validates_presence_of :employee_id
    validates_presence_of :start_date
    validates_presence_of :end_date
    validates_presence_of :subject
    
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
        new_object.start_date = params[:start_date]
        new_object.end_date = params[:end_date]
        new_object.subject = params[:subject]
        new_object.organizer = params[:organizer]
        new_object.place = params[:place]
        new_object.company = params[:company]
        new_object.result = params[:result]
        
        new_object.save
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.employee_id = params[:employee_id]
        self.start_date = params[:start_date]
        self.end_date = params[:end_date]
        self.subject = params[:subject]
        self.organizer = params[:organizer]
        self.place = params[:place]
        self.company = params[:company]
        self.result = params[:result]
        
        self.save
        
        return self 
    end
    
    #object.deleted_object
    def delete_object
        self.destroy 
    end
end
