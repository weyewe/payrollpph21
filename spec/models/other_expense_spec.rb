require 'rails_helper'

RSpec.describe OtherExpense, type: :model do
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
    other_expense = OtherExpense.create_object(
        :employee_id => @employee.id,
        :date => DateTime.new(2015,2,8),
        :is_taxable => true,
        :value => 1250000
      )
      
    other_expense.should be_valid
  end
  
  it "should not allow object creation without employee id" do
    other_expense = OtherExpense.create_object( 
        :employee_id => "",
        :date => DateTime.new(2015,2,8),
        :is_taxable => true,
        :value => 1250000
      )
      
    other_expense.should_not be_valid
  end
  
  it "should not allow object creation with invalid employee id" do
    other_expense = OtherExpense.create_object( 
        :employee_id => 0,
        :date => DateTime.new(2015,2,8),
        :is_taxable => true,
        :value => 1250000
      )
      
    other_expense.should_not be_valid
  end
  
  it "should not allow object creation without date" do
    other_expense = OtherExpense.create_object( 
        :employee_id => @employee.id,
        :date => "",
        :is_taxable => true,
        :value => 1250000
      )
      
    other_expense.should_not be_valid
  end
  
  it "should allow object creation without value" do
    other_expense = OtherExpense.create_object(
        :employee_id => @employee.id,
        :date => DateTime.new(2015,2,8),
        :is_taxable => true,
        :value => ""
      )
      
    other_expense.should_not be_valid
  end
  
  it "should allow object creation with invalid value" do
    other_expense = OtherExpense.create_object(
        :employee_id => @employee.id,
        :date => DateTime.new(2015,2,8),
        :is_taxable => true,
        :value => 0
      )
      
    other_expense.should_not be_valid
  end
  
  context "has been created other_expense" do
    before(:each) do
      @other_expense = OtherExpense.create_object(
          :employee_id => @employee.id,
          :date => DateTime.new(2015,2,8),
          :is_taxable => true,
          :value => 1250000
        )
        
      @other_expense_2 = OtherExpense.create_object(
          :employee_id => @employee.id,
          :date => DateTime.new(2015,3,8),
          :is_taxable => true,
          :value => 1250000
        )
    end
    
    it "should have 2 objects" do
      OtherExpense.count.should == 2 
    end
    
    it "should create valid objects" do
      @other_expense.should be_valid
      @other_expense_2.should be_valid
    end
    
    it "should be allowed to update" do
      @other_expense.update_object(
          :employee_id => @employee.id,
          :date => DateTime.new(2015,2,8),
          :is_taxable => false,
          :value => 1250000
        )
        
      @other_expense.should be_valid
      
      @other_expense.reload 
    end
    
    it "should be allowed to delete object 2" do
      @other_expense_2.delete_object
      
      @other_expense_2.should be_valid
    end
    
    context "has been deleted private other_expense" do
        before(:each) do
            @other_expense_2.delete_object
        end
        
        it "should delete valid object" do
            @other_expense_2.should be_valid
        end
        
        it "should be allowed to create object 3" do
          @other_expense_3 = OtherExpense.create_object(
              :employee_id => @employee.id,
              :date => DateTime.new(2015,3,8),
              :is_taxable => true,
              :value => 1250000
            )
          
          @other_expense_3.should be_valid
        end
    end
    
  end
end
