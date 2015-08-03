require 'rails_helper'

RSpec.describe EmployeeOffice, type: :model do
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
    employee_office = EmployeeOffice.create_object(
        :employee_id => @employee.id,
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id
      )
      
    employee_office.should be_valid
  end
  
  it "should allow object creation without employee" do
    employee_office = EmployeeOffice.create_object(
        :employee_id => "",
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id
      )
      
    employee_office.should_not be_valid
  end
  
  it "should allow object creation with invalid employee" do
    employee_office = EmployeeOffice.create_object(
        :employee_id => 0,
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id
      )
      
    employee_office.should_not be_valid
  end
  
  it "should allow object creation without office" do
    employee_office = EmployeeOffice.create_object(
        :employee_id => @employee.id,
        :office_id => "",
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id
      )
      
    employee_office.should_not be_valid
  end
  
  it "should allow object creation with invalid office" do
    employee_office = EmployeeOffice.create_object(
        :employee_id => @employee.id,
        :office_id => 0,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id
      )
      
    employee_office.should_not be_valid
  end
  
  it "should allow object creation without branch office" do
    employee_office = EmployeeOffice.create_object(
        :employee_id => @employee.id,
        :office_id => @office.id,
        :branch_office_id => "",
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id
      )
      
    employee_office.should_not be_valid
  end
  
  it "should allow object creation with invalid branch office" do
    employee_office = EmployeeOffice.create_object(
        :employee_id => @employee.id,
        :office_id => @office.id,
        :branch_office_id => 0,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id
      )
      
    employee_office.should_not be_valid
  end
  
  it "should allow object creation without department" do
    employee_office = EmployeeOffice.create_object(
        :employee_id => @employee.id,
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => "",
        :division_id => @division.id,
        :title_id => @title.id
      )
      
    employee_office.should_not be_valid
  end
  
  it "should allow object creation with invalid department" do
    employee_office = EmployeeOffice.create_object(
        :employee_id => @employee.id,
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => 0,
        :division_id => @division.id,
        :title_id => @title.id
      )
      
    employee_office.should_not be_valid
  end
  
  it "should allow object creation without division" do
    employee_office = EmployeeOffice.create_object(
        :employee_id => @employee.id,
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => "",
        :title_id => @title.id
      )
      
    employee_office.should_not be_valid
  end
  
  it "should allow object creation with invalid division" do
    employee_office = EmployeeOffice.create_object(
        :employee_id => @employee.id,
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => 0,
        :title_id => @title.id
      )
      
    employee_office.should_not be_valid
  end
  
  it "should allow object creation without title" do
    employee_office = EmployeeOffice.create_object(
        :employee_id => @employee.id,
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => ""
      )
      
    employee_office.should_not be_valid
  end
  
  it "should allow object creation with invalid title" do
    employee_office = EmployeeOffice.create_object(
        :employee_id => @employee.id,
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => 0
      )
      
    employee_office.should_not be_valid
  end
end
