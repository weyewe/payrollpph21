class Loan < ActiveRecord::Base
    belongs_to :employee
    
    validates_presence_of :employee_id
    validates_presence_of :date
    validates_presence_of :value
    validates_presence_of :interest
    validates_presence_of :total
    validates_presence_of :installment_time
    validates_presence_of :installment_value
    validates_presence_of :installment_start
    validates_presence_of :installment_end
    
    #validates_uniqueness_of :code
    
    validate :valid_employee_id
    validate :valid_exist_loan
    validate :valid_value_must_be_grather_than_zero
    validate :valid_total_must_be_grather_than_zero
    validate :valid_installment_time_must_be_grather_than_zero
    
    def valid_installment_time_must_be_grather_than_zero
        return if not installment_time.present?
        
        if installment_time <= 0
            self.errors.add(:installment_time, "Harus lebih besar dari 0")
            return self
        end
    end
    
    def valid_total_must_be_grather_than_zero
        return if not total.present?
        
        if total <= 0
            self.errors.add(:total, "Harus lebih besar dari 0")
            return self
        end
    end
    
    def valid_value_must_be_grather_than_zero
        return if not value.present?
        
        if value <= 0
            self.errors.add(:duration, "Harus lebih besar dari 0")
            return self
        end
    end
    
    def valid_exist_loan
        return if not employee_id.present? 
        
        past_data_list = Loan.where(
                :employee_id => self.employee_id,
                :date => self.date,
                :is_deleted => false
            )
            
        if not self.persisted? and past_data_list.count != 0
            self.errors.add(:employee_id, "tidak boleh duplicate")
            self.errors.add(:date, "tidak boleh duplicate")
            return self
        elsif self.persisted? and past_data_list.count > 0 
            past_data = past_data_list.first 
            if past_data.id != self.id
                self.errors.add(:employee_id, "tidak boleh duplicate")
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
        new_object.value = params[:value]
        new_object.interest = params[:interest]
        new_object.total = params[:total]
        new_object.installment_time = params[:installment_time]
        new_object.installment_value = params[:installment_value]
        new_object.installment_start = params[:installment_start]
        new_object.installment_end = params[:installment_end]
        
        if new_object.save
            date_start = params[:installment_start]
            diff = params[:installment_time]
            
            #Create loan detail installment
            (0.upto (diff-1)).each do |x|
                the_date = date_start + x.months
                
                LoanDetail.create_object(
                    :loan_id => new_object.id,
                    :month => the_date,
                    :amount => params[:installment_value]
                )
            end
        end
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.employee_id = params[:employee_id]
        self.date = params[:date]
        self.value = params[:value]
        self.interest = params[:interest]
        self.total = params[:total]
        self.installment_time = params[:installment_time]
        self.installment_value = params[:installment_value]
        self.installment_start = params[:installment_start]
        self.installment_end = params[:installment_end]
        
        self.save
        
        return self 
    end
    
    #object.deleted_object
    def delete_object
        if self.is_deleted
            self.errors.add(:generic_errors, "Sudah di delete")
            return self
        end
        
        return if not employee_id.present? 
        
        past_data_list = LoanDetail.where(
                :loan_id => self.id,
                :is_paid => true
            )
            
        if self.persisted? and past_data_list.count > 0 
            self.errors.add(:loan, "sudah ada cicilan yang terbayar")
            return self
        end
        
        self.is_deleted = true
        self.deleted_at = DateTime.now 
        self.save 
    end
    
    #object.close_loan
    def close_loan ( params )
        obj_loan_detail = LoanDetail.where{
            (loan_id.eq self.id) &
            (is_closed.eq true)
        }.first
        
        if not obj_loan_detail.nil? and obj_loan_detail.count != 0
            self.errors.add(:loan, "cicilan sudah ditutup")
            return self
        else
            leftover_installment = 0
            LoanDetail.where{
                (loan_id.eq self.id) &
                (is_paid.eq false)
            }.sum("amount")
            
            if (leftover_installment == 0)
                self.errors.add(:loan, "cicilan sudah lunas")
                return self
            end
            
            obj_installment = LoanDetail.where{
                (loan_id.eq self.id) &
                (is_paid.eq false)
            }.each do |inst|
                inst.destroy
            end
            
            LoanDetail.create_object(
                :loan_id => self.id,
                :month => params[:month],
                :amount => leftover_installment + (self.interest/100*leftover_installment),
                :description => "Close Loan on " + params[:month],
                :is_closed => true,
                :is_paid => true
            )
        end
    end
end
