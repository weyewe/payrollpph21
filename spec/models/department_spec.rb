require 'rails_helper'

RSpec.describe Department, type: :model do
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
  end
  
  it "should allow object creation with code and name" do
    code = "IT"
    department = Department.create_object(
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :code => code,
        :name => "IT"
      )
      
    department.should be_valid
    
    department.code.should == code
  end
  
  it "should not allow object creation without office id" do
    code = "IT"
    department = Department.create_object( 
        :office_id => "",
        :branch_office_id => @branch_office.id,
        :code => code,
        :name => "IT"
      )
      
    department.should_not be_valid
  end
  
  it "should not allow object creation with invalid office id" do
    code = "IT"
    department = Department.create_object( 
        :office_id => 0,
        :branch_office_id => @branch_office.id,
        :code => code,
        :name => "IT"
      )
      
    department.should_not be_valid
  end
  
  it "should not allow object creation without branch office id" do
    code = "IT"
    department = Department.create_object( 
        :office_id => @office.id,
        :branch_office_id => "",
        :code => code,
        :name => "IT"
      )
      
    department.should_not be_valid
  end
  
  it "should not allow object creation with invalid branch office id" do
    code = "IT"
    department = Department.create_object( 
        :office_id => @office.id,
        :branch_office_id => 0,
        :code => code,
        :name => "IT"
      )
      
    department.should_not be_valid
  end
  
  it "should not allow object creation without name" do
    code = "IT"
    department = Department.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :code => code,
        :name => ""
      )
      
    department.should_not be_valid
  end
  
  it "should not allow object creation without code" do
    code = "IT"
    department = Department.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :code => "",
        :name => "IT"
      )
      
    department.should_not be_valid
  end
  
  it "should not allow object creation with duplicate code" do
    code = "IT"
    department =  Department.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :code =>  code,
        :name => "IT"
      )
      
    department.should be_valid
    
    department_2 = Department.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :code =>  code,
        :name => "AUDIT"
      )
      
    department_2.should_not be_valid
  end
  
  context "has been created department" do
    before(:each) do
      @department_1_code = "IT"
      @department_1_name = "IT"
      @department = Department.create_object(
          :office_id => @office.id,
          :branch_office_id => @branch_office.id,
          :code =>  @department_1_code,
          :name =>  @department_1_name
        )
        
      @department_2_code = "AUD"
      @department_2_name = "Audit"
      @department_2 = Department.create_object(
          :office_id => @office.id,
          :branch_office_id => @branch_office.id,
          :code => @department_2_code,
          :name => @department_2_name
        )
    end
    
    it "should have 2 objects" do
      Department.count.should == 2 
    end
    
    it "should create valid objects" do
      @department.should be_valid
      @department_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_code = "ACC"
      new_name = "Accounting"
      
      @department.update_object(
          :office_id => @office.id,
          :branch_office_id => @branch_office.id,
          :code => new_code,
          :name => new_name
        )
        
      @department.should be_valid
      
      @department.reload 
      
      @department.name.should == new_name
      @department.code.should == new_code
    end
    
    it "should not allow duplicate code" do
      @department_2.update_object(
          :office_id => @office.id,
          :branch_office_id => @branch_office.id,
          :code => @department_1_code,
          :name => @department_2_name
        )
        
      @department_2.errors.size.should_not == 0 
      @department_2.should_not be_valid
    end
    
    it "should be allowed to delete object 2" do
      @department_2.delete_object
      
      @department_2.persisted?.should be_falsy  # be_truthy 
      
      Department.count.should == 1 
    end
  end
end
