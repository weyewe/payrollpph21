require 'rails_helper'

RSpec.describe Division, type: :model do
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
  end
  
  it "should allow object creation with code and name" do
    code = "PROG"
    division = Division.create_object(
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :code => code,
        :name => "Programmer"
      )
      
    division.should be_valid
    
    division.code.should == code
  end
  
  it "should not allow object creation without office id" do
    code = "PROG"
    division = Division.create_object( 
        :office_id => "",
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :code => code,
        :name => "Programmer"
      )
      
    division.should_not be_valid
  end
  
  it "should not allow object creation with invalid office id" do
    code = "PROG"
    division = Division.create_object( 
        :office_id => 0,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :code => code,
        :name => "Programmer"
      )
      
    division.should_not be_valid
  end
  
  it "should not allow object creation without branch office id" do
    code = "Prog"
    division = Division.create_object( 
        :office_id => @office.id,
        :branch_office_id => "",
        :department_id => @department.id,
        :code => code,
        :name => "Programmer"
      )
      
    division.should_not be_valid
  end
  
  it "should not allow object creation with invalid branch office id" do
    code = "IT"
    division = Division.create_object( 
        :office_id => @office.id,
        :branch_office_id => 0,
        :department_id => @department.id,
        :code => code,
        :name => "IT"
      )
      
    division.should_not be_valid
  end
  
  it "should not allow object creation without department id" do
    code = "Prog"
    division = Division.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => "",
        :code => code,
        :name => "Programmer"
      )
      
    division.should_not be_valid
  end
  
  it "should not allow object creation with invalid department id" do
    code = "PROG"
    division = Division.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => 0,
        :code => code,
        :name => "Programmer"
      )
      
    division.should_not be_valid
  end
  
  it "should not allow object creation without name" do
    code = "PROG"
    division = Division.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :code => code,
        :name => ""
      )
      
    division.should_not be_valid
  end
  
  it "should not allow object creation without code" do
    code = "PROG"
    division = Division.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :code => "",
        :name => "Programmer"
      )
      
    division.should_not be_valid
  end
  
  it "should not allow object creation with duplicate code" do
    code = "PROG"
    division =  Division.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :code =>  code,
        :name => "Programmer"
      )
      
    division.should be_valid
    
    division_2 = Division.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :code =>  code,
        :name => "Support"
      )
      
    division_2.should_not be_valid
  end
  
  context "has been created division" do
    before(:each) do
      @division_1_code = "PROG"
      @division_1_name = "Programmer"
      @division = Division.create_object(
          :office_id => @office.id,
          :branch_office_id => @branch_office.id,
          :department_id => @department.id,
          :code =>  @division_1_code,
          :name =>  @division_1_name
        )
        
      @division_2_code = "SUP"
      @division_2_name = "Support"
      @division_2 = Division.create_object(
          :office_id => @office.id,
          :branch_office_id => @branch_office.id,
          :department_id => @department.id,
          :code => @division_2_code,
          :name => @division_2_name
        )
    end
    
    it "should have 2 objects" do
      Division.count.should == 2 
    end
    
    it "should create valid objects" do
      @division.should be_valid
      @division_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_code = "MKT"
      new_name = "Marketing"
      
      @division.update_object(
          :office_id => @office.id,
          :branch_office_id => @branch_office.id,
          :department_id => @department.id,
          :code => new_code,
          :name => new_name
        )
        
      @division.should be_valid
      
      @division.reload 
      
      @division.name.should == new_name
      @division.code.should == new_code
    end
    
    it "should not allow duplicate code" do
      @division_2.update_object(
          :office_id => @office.id,
          :branch_office_id => @branch_office.id,
          :department_id => @department.id,
          :code => @division_1_code,
          :name => @division_2_name
        )
        
      @division_2.errors.size.should_not == 0 
      @division_2.should_not be_valid
    end
    
    it "should be allowed to delete object 2" do
      @division_2.delete_object
      
      @division_2.persisted?.should be_falsy  # be_truthy 
      
      Division.count.should == 1 
    end
  end
end
