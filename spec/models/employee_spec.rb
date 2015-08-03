require 'rails_helper'

RSpec.describe Employee, type: :model do
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
  end
  
  it "should allow object creation with code and name" do
    code = "007"
    employee = Employee.create_object(
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :code => code,
        :full_name => "Pebrian",
        :nick_name => "Pebri",
        :enroll_id => 12,
        :bank_id => @bank.id
      )
      
    employee.should be_valid
    
    employee.code.should == code
  end
  
  it "should not allow object creation without office id" do
    code = "007"
    employee = Employee.create_object( 
        :office_id => "",
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :code => code,
        :full_name => "Pebrian",
        :nick_name => "Pebri",
        :enroll_id => 12,
        :bank_id => @bank.id
      )
      
    employee.should_not be_valid
  end
  
  it "should not allow object creation with invalid office id" do
    code = "007"
    employee = Employee.create_object( 
        :office_id => 0,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :code => code,
        :full_name => "Pebrian",
        :nick_name => "Pebri",
        :enroll_id => 12,
        :bank_id => @bank.id
      )
      
    employee.should_not be_valid
  end
  
  it "should not allow object creation without branch office id" do
    code = "Prog"
    employee = Employee.create_object( 
        :office_id => @office.id,
        :branch_office_id => "",
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :code => code,
        :full_name => "Pebrian",
        :nick_name => "Pebri",
        :enroll_id => 12,
        :bank_id => @bank.id
      )
      
    employee.should_not be_valid
  end
  
  it "should not allow object creation with invalid branch office id" do
    code = "IT"
    employee = Employee.create_object( 
        :office_id => @office.id,
        :branch_office_id => 0,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :code => code,
        :full_name => "Pebrian",
        :nick_name => "Pebri",
        :enroll_id => 12,
        :bank_id => @bank.id
      )
      
    employee.should_not be_valid
  end
  
  it "should not allow object creation without department id" do
    code = "Prog"
    employee = Employee.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => "",
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :code => code,
        :full_name => "Pebrian",
        :nick_name => "Pebri",
        :enroll_id => 12,
        :bank_id => @bank.id
      )
      
    employee.should_not be_valid
  end
  
  it "should not allow object creation with invalid department id" do
    code = "007"
    employee = Employee.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => 0,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :code => code,
        :full_name => "Pebrian",
        :nick_name => "Pebri",
        :enroll_id => 12,
        :bank_id => @bank.id
      )
      
    employee.should_not be_valid
  end
  
  it "should not allow object creation without division id" do
    code = "Prog"
    employee = Employee.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => "",
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :code => code,
        :full_name => "Pebrian",
        :nick_name => "Pebri",
        :enroll_id => 12,
        :bank_id => @bank.id
      )
      
    employee.should_not be_valid
  end
  
  it "should not allow object creation with invalid division id" do
    code = "007"
    employee = Employee.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department_id,
        :division_id => 0,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :code => code,
        :full_name => "Pebrian",
        :nick_name => "Pebri",
        :enroll_id => 12,
        :bank_id => @bank.id
      )
      
    employee.should_not be_valid
  end
  
  it "should not allow object creation without title id" do
    code = "Prog"
    employee = Employee.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => "",
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :code => code,
        :full_name => "Pebrian",
        :nick_name => "Pebri",
        :enroll_id => 12,
        :bank_id => @bank.id
      )
      
    employee.should_not be_valid
  end
  
  it "should not allow object creation with invalid title id" do
    code = "007"
    employee = Employee.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department_id,
        :division_id => @division.id,
        :title_id => 0,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :code => code,
        :full_name => "Pebrian",
        :nick_name => "Pebri",
        :enroll_id => 12,
        :bank_id => @bank.id
      )
      
    employee.should_not be_valid
  end
  
  it "should not allow object creation without level id" do
    code = "Prog"
    employee = Employee.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => "",
        :status_working_id => @status_working.id,
        :code => code,
        :full_name => "Pebrian",
        :nick_name => "Pebri",
        :enroll_id => 12,
        :bank_id => @bank.id
      )
      
    employee.should_not be_valid
  end
  
  it "should not allow object creation with invalid level id" do
    code = "007"
    employee = Employee.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department_id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => 0,
        :status_working_id => @status_working.id,
        :code => code,
        :full_name => "Pebrian",
        :nick_name => "Pebri",
        :enroll_id => 12,
        :bank_id => @bank.id
      )
      
    employee.should_not be_valid
  end
  
  it "should not allow object creation without working status id" do
    code = "Prog"
    employee = Employee.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => "",
        :code => code,
        :full_name => "Pebrian",
        :nick_name => "Pebri",
        :enroll_id => 12,
        :bank_id => @bank.id
      )
      
    employee.should_not be_valid
  end
  
  it "should not allow object creation with invalid working status id" do
    code = "007"
    employee = Employee.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department_id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => 0,
        :code => code,
        :full_name => "Pebrian",
        :nick_name => "Pebri",
        :enroll_id => 12,
        :bank_id => @bank.id
      )
      
    employee.should_not be_valid
  end
  
  it "should not allow object creation without bank id" do
    code = "Prog"
    employee = Employee.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => "",
        :code => code,
        :full_name => "Pebrian",
        :nick_name => "Pebri",
        :enroll_id => 12,
        :bank_id => ""
      )
      
    employee.should_not be_valid
  end
  
  it "should not allow object creation with invalid bank id" do
    code = "007"
    employee = Employee.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department_id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => 0,
        :code => code,
        :full_name => "Pebrian",
        :nick_name => "Pebri",
        :enroll_id => 12,
        :bank_id => 0
      )
      
    employee.should_not be_valid
  end
  
  it "should not allow object creation without code" do
    code = "007"
    employee = Employee.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department_id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :code => "",
        :full_name => "Pebrian",
        :nick_name => "Pebri",
        :enroll_id => 12,
        :bank_id => @bank.id
      )
      
    employee.should_not be_valid
  end
  
  it "should not allow object creation without full name" do
    code = "007"
    employee = Employee.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department_id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :code => code,
        :full_name => "",
        :nick_name => "Pebri",
        :enroll_id => 12,
        :bank_id => @bank.id
      )
      
    employee.should_not be_valid
  end
  
  it "should not allow object creation without nick name" do
    code = "007"
    employee = Employee.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department_id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :code => code,
        :full_name => "Pebrian",
        :nick_name => "",
        :enroll_id => 12,
        :bank_id => @bank.id
      )
      
    employee.should_not be_valid
  end
  
  it "should not allow object creation without enroll_id" do
    code = "007"
    employee = Employee.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department_id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :code => code,
        :full_name => "",
        :nick_name => "Pebri",
        :enroll_id => "",
        :bank_id => @bank.id
      )
      
    employee.should_not be_valid
  end
  
  it "should not allow object creation with duplicate code" do
    code = "007"
    employee =  Employee.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :code => code,
        :full_name => "Pebrian",
        :nick_name => "Pebri",
        :enroll_id => "12",
        :bank_id => @bank.id
      )
      
    employee.should be_valid
    
    employee_2 = Employee.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :code => code,
        :full_name => "Bambang",
        :nick_name => "Bams",
        :enroll_id => "14",
        :bank_id => @bank.id
      )
      
    employee_2.should_not be_valid
  end
  
  it "should not allow object creation with duplicate enroll" do
    employee =  Employee.create_object( 
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
        :enroll_id => "12",
        :bank_id => @bank.id
      )
      
    employee.should be_valid
    
    employee_2 = Employee.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :code => "008",
        :full_name => "Bambang",
        :nick_name => "Bams",
        :enroll_id => "12",
        :bank_id => @bank.id
      )
      
    employee_2.should_not be_valid
  end
  
  context "has been created employee" do
    before(:each) do
      @employee_1_code = "007"
      @employee_1_full_name = "Pebrian"
      @employee_1_nick_name = "Pebri"
      @employee_1_enroll_id = "12"
      @employee = Employee.create_object(
          :office_id => @office.id,
          :branch_office_id => @branch_office.id,
          :department_id => @department.id,
          :division_id => @division.id,
          :title_id => @title.id,
          :level_id => @level.id,
          :status_working_id => @status_working.id,
          :code => @employee_1_code,
          :full_name => @employee_1_full_name,
          :nick_name => @employee_1_nick_name,
          :enroll_id => @employee_1_enroll_id,
          :bank_id => @bank.id
        )
        
      @employee_2_code = "008"
      @employee_2_full_name = "Bambang"
      @employee_2_nick_name = "Bams"
      @employee_2_enroll_id = "14"
      @employee_2 = Employee.create_object(
          :office_id => @office.id,
          :branch_office_id => @branch_office.id,
          :department_id => @department.id,
          :division_id => @division.id,
          :title_id => @title.id,
          :level_id => @level.id,
          :status_working_id => @status_working.id,
          :code => @employee_2_code,
          :full_name => @employee_2_full_name,
          :nick_name => @employee_2_nick_name,
          :enroll_id => @employee_2_enroll_id,
          :bank_id => @bank.id
        )
    end
    
    it "should have 2 objects" do
      Employee.count.should == 2 
    end
    
    it "should create valid objects" do
      @employee.should be_valid
      @employee_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_code = "009"
      new_full_name = "Handendari"
      new_nick_name = "Andris"
      new_enroll_id = 32
      
      @employee.update_object(
          :office_id => @office.id,
          :branch_office_id => @branch_office.id,
          :department_id => @department.id,
          :division_id => @division.id,
          :title_id => @title.id,
          :level_id => @level.id,
          :status_working_id => @status_working.id,
          :code => new_code,
          :full_name => new_full_name,
          :nick_name => new_nick_name,
          :enroll_id => new_enroll_id,
          :bank_id => @bank.id
        )
        
      @employee.should be_valid
      
      @employee.reload 
      
      @employee.code.should == new_code
      @employee.full_name.should == new_full_name
      @employee.nick_name.should == new_nick_name
      @employee.enroll_id.should == new_enroll_id
    end
    
    it "should not allow duplicate code" do
      @employee_2.update_object(
          :office_id => @office.id,
          :branch_office_id => @branch_office.id,
          :department_id => @department.id,
          :division_id => @division.id,
          :title_id => @title.id,
          :level_id => @level.id,
          :status_working_id => @status_working.id,
          :code => @employee_1_code,
          :full_name => @employee_2_full_name,
          :nick_name => @employee_2_nick_name,
          :enroll_id => @employee_2_enroll_id,
          :bank_id => @bank.id
        )
        
      @employee_2.errors.size.should_not == 0 
      @employee_2.should_not be_valid
    end
    
    it "should be allowed to delete object 2" do
      @employee_2.delete_object
      
      @employee_2.should be_valid
    end
  end
  
end
