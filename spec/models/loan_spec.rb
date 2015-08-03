require 'rails_helper'

RSpec.describe Loan, type: :model do
  before (:each) do
      @office = Office.create_object(
            :code => "SSD",
            :name => "Solusi Sentral Data"
          )
          
      @branch_office = BranchOffice.create_object(
            :office_id => @office.id,
            :code => "SSDSUB",
            :name => "Solusi Sentral Data - Surabaya"
          )
          
      @department = Department.create_object(
            :office_id => @office.id,
            :branch_office_id => @branch_office.id,
            :code => "IT",
            :name => "IT"
          )
     
      @division = Division.create_object(
            :office_id => @office.id,
            :branch_office_id => @branch_office.id,
            :department_id => @department.id,
            :code => "007",
            :name => "Programmer"
          )
      
      @title = Title.create_object(
            :office_id => @office.id,
            :code => "J007",
            :name => "Junior Programmer"
          )
      
      @level = Level.create_object(
            :office_id => @office.id,
            :code => "STF",
            :name => "Staff"
          )
      
      @status_working = StatusWorking.create_object(
            :office_id => @office.id,
            :code => "PMT",
            :name => "Permanent"
          )
      
      @bank = Bank.create_object(
            :office_id => @office.id,
            :code => "BCA",
            :name => "Bank Central Asia"
          )
      
      @employee = Employee.create_object(
            :office_id => @office.id,
            :branch_office_id => @branch_office.id,
            :department_id => @department.id,
            :division_id => @division.id,
            :title_id => @title.id,
            :level_id => @level.id,
            :status_working_id => @status_working.id,
            :code => "007",
            :full_name => "Pebrian",
            :nick_name => "Pebri",
            :enroll_id => 12,
            :bank_id => @bank.id
          )
  end
  
  it "should allow object creation with all required field" do
    loan = Loan.create_object(
        :employee_id => @employee.id,
        :date => DateTime.new(2015,2,8),
        :value => 1000000,
        :interest => 0,
        :total => 1000000,
        :installment_time => 10,
        :installment_value => 100000,
        :installment_start => DateTime.new(2015,1,1),
        :installment_end => DateTime.new(2015,10,31)
      )
      
    loan.should be_valid
  end
  
  it "should not allow object creation without employee id" do
    loan = Loan.create_object( 
        :employee_id => "",
        :date => DateTime.new(2015,2,8),
        :value => 1000000,
        :interest => 0,
        :total => 1000000,
        :installment_time => 10,
        :installment_value => 100000,
        :installment_start => DateTime.new(2015,1,1),
        :installment_end => DateTime.new(2015,10,31)
      )
      
    loan.should_not be_valid
  end
  
  it "should not allow object creation with invalid employee id" do
    loan = Loan.create_object( 
        :employee_id => 0,
        :date => DateTime.new(2015,2,8),
        :value => 1000000,
        :interest => 0,
        :total => 1000000,
        :installment_time => 10,
        :installment_value => 100000,
        :installment_start => DateTime.new(2015,1,1),
        :installment_end => DateTime.new(2015,10,31)
      )
      
    loan.should_not be_valid
  end
  
  it "should allow object creation without date" do
    loan = Loan.create_object(
        :employee_id => @employee.id,
        :date => "",
        :value => 1000000,
        :interest => 0,
        :total => 1000000,
        :installment_time => 10,
        :installment_value => 100000,
        :installment_start => DateTime.new(2015,1,1),
        :installment_end => DateTime.new(2015,10,31)
      )
      
    loan.should_not be_valid
  end
  
  it "should allow object creation without value" do
    loan = Loan.create_object(
        :employee_id => @employee.id,
        :date => DateTime.new(2015,2,8),
        :value => "",
        :interest => 0,
        :total => 1000000,
        :installment_time => 10,
        :installment_value => 100000,
        :installment_start => DateTime.new(2015,1,1),
        :installment_end => DateTime.new(2015,10,31)
      )
      
    loan.should_not be_valid
  end
  
  it "should allow object creation with invalid value" do
    loan = Loan.create_object(
        :employee_id => @employee.id,
        :date => DateTime.new(2015,2,8),
        :value => 0,
        :interest => 0,
        :total => 1000000,
        :installment_time => 10,
        :installment_value => 100000,
        :installment_start => DateTime.new(2015,1,1),
        :installment_end => DateTime.new(2015,10,31)
      )
      
    loan.should_not be_valid
  end
  
  it "should allow object creation without interest" do
    loan = Loan.create_object(
        :employee_id => @employee.id,
        :date => DateTime.new(2015,2,8),
        :value => 1000000,
        :interest => "",
        :total => 1000000,
        :installment_time => 10,
        :installment_value => 100000,
        :installment_start => DateTime.new(2015,1,1),
        :installment_end => DateTime.new(2015,10,31)
      )
      
    loan.should_not be_valid
  end
  
  it "should allow object creation without total" do
    loan = Loan.create_object(
        :employee_id => @employee.id,
        :date => DateTime.new(2015,2,8),
        :value => 1000000,
        :interest => 0,
        :total => "",
        :installment_time => 10,
        :installment_value => 100000,
        :installment_start => DateTime.new(2015,1,1),
        :installment_end => DateTime.new(2015,10,31)
      )
      
    loan.should_not be_valid
  end
  
  it "should allow object creation without installment time" do
    loan = Loan.create_object(
        :employee_id => @employee.id,
        :date => DateTime.new(2015,2,8),
        :value => 1000000,
        :interest => 0,
        :total => 1000000,
        :installment_time => "",
        :installment_value => 100000,
        :installment_start => DateTime.new(2015,1,1),
        :installment_end => DateTime.new(2015,10,31)
      )
      
    loan.should_not be_valid
  end
  
  it "should allow object creation with invalid installment time" do
    loan = Loan.create_object(
        :employee_id => @employee.id,
        :date => DateTime.new(2015,2,8),
        :value => 1000000,
        :interest => 0,
        :total => 1000000,
        :installment_time => 0,
        :installment_value => 100000,
        :installment_start => DateTime.new(2015,1,1),
        :installment_end => DateTime.new(2015,10,31)
      )
      
    loan.should_not be_valid
  end
  
  it "should allow object creation without installment value" do
    loan = Loan.create_object(
        :employee_id => @employee.id,
        :date => DateTime.new(2015,2,8),
        :value => 1000000,
        :interest => 0,
        :total => 1000000,
        :installment_time => 10,
        :installment_value => "",
        :installment_start => DateTime.new(2015,1,1),
        :installment_end => DateTime.new(2015,10,31)
      )
      
    loan.should_not be_valid
  end
  
  it "should allow object creation without installment start" do
    loan = Loan.create_object(
        :employee_id => @employee.id,
        :date => DateTime.new(2015,2,8),
        :value => 1000000,
        :interest => 0,
        :total => 1000000,
        :installment_time => 10,
        :installment_value => 100000,
        :installment_start => "",
        :installment_end => DateTime.new(2015,10,31)
      )
      
    loan.should_not be_valid
  end
  
  it "should allow object creation without installment end" do
    loan = Loan.create_object(
        :employee_id => @employee.id,
        :date => DateTime.new(2015,2,8),
        :value => 1000000,
        :interest => 0,
        :total => 1000000,
        :installment_time => 10,
        :installment_value => 100000,
        :installment_start => DateTime.new(2015,1,1),
        :installment_end => ""
      )
      
    loan.should_not be_valid
  end
  
  context "has been created loan" do
    before(:each) do
      @loan = Loan.create_object(
          :employee_id => @employee.id,
          :date => DateTime.new(2015,2,8),
          :value => 1000000,
          :interest => 0,
          :total => 1000000,
          :installment_time => 10,
          :installment_value => 100000,
          :installment_start => DateTime.new(2015,1,1),
          :installment_end => DateTime.new(2015,10,31)
        )
        
      @loan_2 = Loan.create_object(
          :employee_id => @employee.id,
          :date => DateTime.new(2015,3,8),
          :value => 15000000,
          :interest => 0,
          :total => 1500000,
          :installment_time => 15,
          :installment_value => 150000,
          :installment_start => DateTime.new(2015,1,1),
          :installment_end => DateTime.new(2016,3,31)
        )
    end
    
    it "should have 2 objects" do
      Loan.count.should == 2 
    end
    
    it "should create valid objects" do
      @loan.should be_valid
      @loan_2.should be_valid
    end
    
    it "should be allowed to update" do
      @loan.update_object(
          :employee_id => @employee.id,
          :date => DateTime.new(2015,2,8),
          :value => 2000000,
          :interest => 0,
          :total => 2000000,
          :installment_time => 10,
          :installment_value => 200000,
          :installment_start => DateTime.new(2015,1,1),
          :installment_end => DateTime.new(2015,10,31)
        )
        
      @loan.should be_valid
      
      @loan.reload 
    end
    
    it "should be allowed to delete object 2" do
      @loan_2.delete_object
      
      @loan_2.should be_valid
    end
    
    it "should be allowed to close loan" do
      @loan_2.close_loan(
          :month => DateTime.new(2015,1,1)
      )
      
      @loan_2.should be_valid
    end
    
    context "has been deleted private leave" do
        before(:each) do
            @loan_2.delete_object
        end
        
        it "should delete valid object" do
            @loan_2.should be_valid
        end
        
        it "should be allowed to create object 3" do
          @loan_3 = Loan.create_object(
              :employee_id => @employee.id,
              :date => DateTime.new(2015,3,8),
              :value => 15000000,
              :interest => 0,
              :total => 1500000,
              :installment_time => 15,
              :installment_value => 150000,
              :installment_start => DateTime.new(2015,1,1),
              :installment_end => DateTime.new(2016,3,31)
            )
          
          @loan_3.should be_valid
        end
    end
    
  end
end
