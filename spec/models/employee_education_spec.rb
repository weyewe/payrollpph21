require 'rails_helper'

RSpec.describe EmployeeEducation, type: :model do
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
    employee_education = EmployeeEducation.create_object(
        :employee_id => @employee.id,
        :level => EDUCATION_LEVEL[:s1],
        :range_year => "2010 - 2014"
      )
      
    employee_education.should be_valid
    
    employee_education.level.should == EDUCATION_LEVEL[:s1]
    employee_education.range_year.should == "2010 - 2014"
  end
  
  it "should not allow object creation without employee id" do
    employee_education = EmployeeEducation.create_object( 
        :employee_id => "",
        :level => EDUCATION_LEVEL[:s1],
        :range_year => "2010 - 2014"
      )
      
    employee_education.should_not be_valid
  end
  
  it "should not allow object creation with invalid employee id" do
    employee_education = EmployeeEducation.create_object( 
        :employee_id => 0,
        :level => EDUCATION_LEVEL[:s1],
        :range_year => "2010 - 2014"
      )
      
    employee_education.should_not be_valid
  end
  
  it "should not allow object creation without level" do
    employee_education = EmployeeEducation.create_object( 
        :employee_id => @employee.id,
        :level => "",
        :range_year => "2010 - 2014"
      )
      
    employee_education.should_not be_valid
  end
  
  it "should not allow object creation without range year" do
    employee_education = EmployeeEducation.create_object( 
        :employee_id => @employee.id,
        :level => EDUCATION_LEVEL[:s1],
        :range_year => ""
      )
      
    employee_education.should_not be_valid
  end
  
  context "has been created employee_education" do
    before(:each) do
      @employee_education_1_level = EDUCATION_LEVEL[:s1]
      @employee_education_1_range_year = "2010 - 2014"
      @employee_education = EmployeeEducation.create_object(
          :employee_id => @employee.id,
          :level => @employee_education_1_level,
          :range_year => @employee_education_1_range_year
        )
        
      @employee_education_2_level = EDUCATION_LEVEL[:s2]
      @employee_education_2_range_year = "2011 - 2015"
      @employee_education_2 = EmployeeEducation.create_object(
          :employee_id => @employee.id,
          :level => @employee_education_2_level,
          :range_year => @employee_education_2_range_year
        )
    end
    
    it "should have 2 objects" do
      EmployeeEducation.count.should == 2 
    end
    
    it "should create valid objects" do
      @employee_education.should be_valid
      @employee_education_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_level = EDUCATION_LEVEL[:d3]
      new_range_year = "2009 - 2011"
      
      @employee_education.update_object(
          :employee_id => @employee.id,
          :level => new_level,
          :range_year => new_range_year
        )
        
      @employee_education.should be_valid
      
      @employee_education.reload 
      
      @employee_education.level.should == new_level
      @employee_education.range_year.should == new_range_year
    end
    
    it "should be allowed to delete object 2" do
      @employee_education_2.delete_object
      
      @employee_education_2.persisted?.should be_falsy  # be_truthy 
      
      EmployeeEducation.count.should == 1 
    end
  end
end
