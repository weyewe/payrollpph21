require 'rails_helper'

RSpec.describe EmployeeSkill, type: :model do
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
  
  it "should allow object creation with code and name" do
    employee_skill = EmployeeSkill.create_object(
        :employee_id => @employee.id,
        :name => "visual basic",
        :level => SKILL_LEVEL[:good]
      )
      
    employee_skill.should be_valid
    
    employee_skill.name.should == "visual basic"
    employee_skill.level.should == SKILL_LEVEL[:good]
  end
  
  it "should not allow object creation without employee id" do
    employee_skill = EmployeeSkill.create_object( 
        :employee_id => "",
        :name => "visual basic",
        :level => SKILL_LEVEL[:good]
      )
      
    employee_skill.should_not be_valid
  end
  
  it "should not allow object creation with invalid employee id" do
    employee_skill = EmployeeSkill.create_object( 
        :employee_id => 0,
        :name => "visual basic",
        :level => SKILL_LEVEL[:good]
      )
      
    employee_skill.should_not be_valid
  end
  
  it "should not allow object creation without name" do
    employee_skill = EmployeeSkill.create_object( 
        :employee_id => @employee.id,
        :name => "",
        :level => SKILL_LEVEL[:good]
      )
      
    employee_skill.should_not be_valid
  end
  
  it "should not allow object creation without level" do
    employee_skill = EmployeeSkill.create_object( 
        :employee_id => @employee.id,
        :name => "visual basic",
        :level => ""
      )
      
    employee_skill.should_not be_valid
  end
  
  context "has been created employee_skill" do
    before(:each) do
      @employee_skill_1_name = "visual basic"
      @employee_skill_1_level = SKILL_LEVEL[:good]
      @employee_skill = EmployeeSkill.create_object(
          :employee_id => @employee.id,
          :name => @employee_skill_1_name,
          :level => @employee_skill_1_level
        )
        
      @employee_skill_2_name = "php"
      @employee_skill_2_level = SKILL_LEVEL[:good]
      @employee_skill_2 = EmployeeSkill.create_object(
          :employee_id => @employee.id,
          :name => @employee_skill_2_name,
          :level => @employee_skill_2_level
        )
    end
    
    it "should have 2 objects" do
      EmployeeSkill.count.should == 2 
    end
    
    it "should create valid objects" do
      @employee_skill.should be_valid
      @employee_skill_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_name = "delphi"
      new_level = SKILL_LEVEL[:average]
      
      @employee_skill.update_object(
          :employee_id => @employee.id,
          :name => new_name,
          :level => new_level
        )
        
      @employee_skill.should be_valid
      
      @employee_skill.reload 
      
      @employee_skill.name.should == new_name
      @employee_skill.level.should == new_level
    end
    
    it "should be allowed to delete object 2" do
      @employee_skill_2.delete_object
      
      @employee_skill_2.persisted?.should be_falsy  # be_truthy 
      
      EmployeeSkill.count.should == 1 
    end
  end
end
