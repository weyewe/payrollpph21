require 'rails_helper'

RSpec.describe EmployeeContract, type: :model do
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
            :bank_id => @bank.id,
            :start_working => DateTime.new(2014,1,1)
          )
  end
  
  it "should allow object creation with code and name" do
    employee_contract = EmployeeContract.create_object(
        :employee_id => @employee.id,
        :start_date => DateTime.new(2015,02,01),
        :end_date => DateTime.new(2015,05,30),
        :no => "XX/2015/V/001"
      )
      
    employee_contract.should be_valid
    
    employee_contract.start_date.should == DateTime.new(2015,02,01)
    employee_contract.end_date.should == DateTime.new(2015,05,30)
    employee_contract.no.should == "XX/2015/V/001"
  end
  
  it "should not allow object creation without employee id" do
    employee_contract = EmployeeContract.create_object( 
        :employee_id => "",
        :start_date => DateTime.new(2015,02,01),
        :end_date => DateTime.new(2015,05,30),
        :no => "XX/2015/V/001"
      )
      
    employee_contract.should_not be_valid
  end
  
  it "should not allow object creation with invalid employee id" do
    employee_contract = EmployeeContract.create_object( 
        :employee_id => "",
        :start_date => DateTime.new(2015,02,01),
        :end_date => DateTime.new(2015,05,30),
        :no => "XX/2015/V/001"
      )
      
    employee_contract.should_not be_valid
  end
  
  it "should not allow object creation without start date" do
    employee_contract = EmployeeContract.create_object( 
        :employee_id => @employee.id,
        :start_date => "",
        :end_date => DateTime.new(2015,05,30),
        :no => "XX/2015/V/001"
      )
      
    employee_contract.should_not be_valid
  end
  
  it "should not allow object creation without end date" do
    employee_contract = EmployeeContract.create_object( 
        :employee_id => @employee.id,
        :start_date => DateTime.new(2015,02,01),
        :end_date => "",
        :no => "XX/2015/V/001"
      )
      
    employee_contract.should_not be_valid
  end
  
  it "should not allow object creation without no" do
    employee_contract = EmployeeContract.create_object( 
        :employee_id => @employee.id,
        :start_date => DateTime.new(2015,02,01),
        :end_date => DateTime.new(2015,05,30),
        :no => ""
      )
      
    employee_contract.should_not be_valid
  end
  
  context "has been created employee_contract" do
    before(:each) do
      @employee_contract_1_start_date = DateTime.new(2015,02,01)
      @employee_contract_1_end_date = DateTime.new(2015,05,30)
      @employee_contract_1_no = "XX/2015/V/001"
      @employee_contract = EmployeeContract.create_object(
          :employee_id => @employee.id,
          :start_date => @employee_contract_1_start_date,
          :end_date => @employee_contract_1_end_date,
          :no => @employee_contract_1_no
        )
        
      @employee_contract_2_start_date = DateTime.new(2015,03,11)
      @employee_contract_2_end_date = DateTime.new(2015,06,10)
      @employee_contract_2_no = "XX/2015/III/012"
      @employee_contract_2 = EmployeeContract.create_object(
          :employee_id => @employee.id,
          :start_date => @employee_contract_2_start_date,
          :end_date => @employee_contract_2_end_date,
          :no => @employee_contract_2_no
        )
    end
    
    it "should have 2 objects" do
      EmployeeContract.count.should == 2 
    end
    
    it "should create valid objects" do
      @employee_contract.should be_valid
      @employee_contract_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_start_date = DateTime.new(2015,02,21)
      new_end_date = DateTime.new(2015,05,20)
      new_no = "XX/2015/II/201"
      
      @employee_contract.update_object(
          :employee_id => @employee.id,
          :start_date => new_start_date,
          :end_date => new_end_date,
          :no => new_no
        )
        
      @employee_contract.should be_valid
      
      @employee_contract.reload 
      
      @employee_contract.start_date.should == new_start_date
      @employee_contract.end_date.should == new_end_date
      @employee_contract.no.should == new_no
    end
    
    it "should be allowed to delete object 2" do
      @employee_contract_2.delete_object
      
      @employee_contract_2.persisted?.should be_falsy  # be_truthy 
      
      EmployeeContract.count.should == 1 
    end
  end
end
