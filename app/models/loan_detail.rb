class LoanDetail < ActiveRecord::Base
    belongs_to :employee
    
    validates_presence_of :loan_id
    validates_presence_of :month
    validates_presence_of :amount
    
    #object.create_object
    def self.create_object( params ) 
        new_object = self.new
        
        new_object.loan_id = params[:loan_id]
        new_object.month = params[:month]
        new_object.amount = params[:amount]
        
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
        if self.is_paid
            self.errors.add(:generic_errors, "Sudah di bayar")
            return self
        end
        
        self.is_paid = true
        self.save 
    end
    
    # #object.deleted_object
    # def closed_object ( params )
    #     if self.is_closed
    #         self.errors.add(:generic_errors, "Sudah dilunasi")
    #         return self
    #     end
        
    #     leftover_installment = LoanDetail.where{
    #         (loan_id.eq self.loan_id) &
    #         (is_paid.eq false)
    #     }.sum
        
    #     if (leftover_installment == 0)
    #         self.errors.add(:loan, "cicilan sudah lunas")
    #         return self
    #     end
        
    #     obj_installment = LoanDetail.where{
    #         (loan_id.eq self.id) &
    #         (is_paid.eq false)
    #     }.each do |inst|
    #         inst.destroy
    #     end
        
    #     obj_loan = Loan.where{
    #         (id.eq self.loan_id)
    #     }.first
        
    #     current_interest = obj_loan.interest
    #     current_loan_id = obj_loan.id
        
    #     new_object = self.new
        
    #     new_object.loan_id = current_loan_id
    #     new_object.month = params[:month]
    #     new_object.amount = leftover_installment + (current_interest/100*leftover_installment)
    #     new_object.description = "Close Loan on " + params[:month]
    #     new_object.is_closed = true
        
    #     return new_object
    # end
end
