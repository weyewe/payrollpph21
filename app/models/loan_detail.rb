class LoanDetail < ActiveRecord::Base
    belongs_to :employee
    belongs_to :loan
    
    validates_presence_of :loan_id
    validates_presence_of :month
    validates_presence_of :amount
    
    #object.create_object
    def self.create_object( params ) 
        new_object = self.new
        
        new_object.loan_id = params[:loan_id]
        new_object.month = params[:month]
        new_object.amount = params[:amount]
        
        new_object.save
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.loan_id = params[:loan_id]
        self.month = params[:month]
        self.amount = params[:amount]
        
        self.save
        
        return self 
    end
    
    #object.deleted_object
    def paid_object
        self.is_paid = true
        self.save 
    end
    
    def delete_object
        self.is_deleted = true
        self.deleted_at = DateTime.now
        self.save
    end
end
