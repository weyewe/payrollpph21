require 'rails_helper'

RSpec.describe EmployeeRelationship, type: :model do
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
    employee_relation = EmployeeRelationship.create_object(
        :employee_id => @employee.id,
        :name => "Lisa",
        :relationship => EMPLOYEE_RELATIONSHIP[:sister]
      )
      
    employee_relation.should be_valid
    
    employee_relation.name.should == "Lisa"
    employee_relation.relationship.should == EMPLOYEE_RELATIONSHIP[:sister]
  end
  
  it "should not allow object creation without employee id" do
    employee_relation = EmployeeRelationship.create_object( 
        :employee_id => "",
        :name => "Lisa",
        :relationship => EMPLOYEE_RELATIONSHIP[:sister]
      )
      
    employee_relation.should_not be_valid
  end
  
  it "should not allow object creation with invalid employee id" do
    employee_relation = EmployeeRelationship.create_object( 
        :employee_id => 0,
        :name => "Lisa",
        :relationship => EMPLOYEE_RELATIONSHIP[:sister]
      )
      
    employee_relation.should_not be_valid
  end
  
  it "should not allow object creation without name" do
    employee_relation = EmployeeRelationship.create_object( 
        :employee_id => @employee.id,
        :name => "",
        :relationship => EMPLOYEE_RELATIONSHIP[:sister]
      )
      
    employee_relation.should_not be_valid
  end
  
  it "should not allow object creation without relationship" do
    employee_relation = EmployeeRelationship.create_object( 
        :employee_id => @employee.id,
        :name => "Lisa",
        :relationship => ""
      )
      
    employee_relation.should_not be_valid
  end
  
  context "has been created employee_relation" do
    before(:each) do
      @employee_relation_1_name = "Lisa"
      @employee_relation_1_relationship = EMPLOYEE_RELATIONSHIP[:sister]
      @employee_relation = EmployeeRelationship.create_object(
          :employee_id => @employee.id,
          :name =>  @employee_relation_1_name,
          :relationship =>  @employee_relation_1_relationship
        )
        
      @employee_relation_2_name = "Bayu"
      @employee_relation_2_relationship = EMPLOYEE_RELATIONSHIP[:brother]
      @employee_relation_2 = EmployeeRelationship.create_object(
          :employee_id => @employee.id,
          :name => @employee_relation_2_name,
          :relationship => @employee_relation_2_relationship
        )
    end
    
    it "should have 2 objects" do
      EmployeeRelationship.count.should == 2 
    end
    
    it "should create valid objects" do
      @employee_relation.should be_valid
      @employee_relation_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_name = "Githa"
      new_relationship = EMPLOYEE_RELATIONSHIP[:wife]
      
      @employee_relation.update_object(
          :employee_id => @employee.id,
          :name => new_name,
          :relationship => new_relationship
        )
        
      @employee_relation.should be_valid
      
      @employee_relation.reload 
      
      @employee_relation.name.should == new_name
      @employee_relation.relationship.should == new_relationship
    end
    
    # it "should not allow duplicate code" do
    #   @employee_relation_2.update_object(
    #       :employee_id => @employee.id,
    #       :name => @employee_relation_2_code,
    #       :relationship => @employee_relation_2_name
    #     )
        
    #   @employee_relation_2.errors.size.should_not == 0 
    #   @employee_relation_2.should_not be_valid
    # end
    
    it "should be allowed to delete object 2" do
      @employee_relation_2.delete_object
      
      @employee_relation_2.persisted?.should be_falsy  # be_truthy 
      
      EmployeeRelationship.count.should == 1 
    end
  end
end
