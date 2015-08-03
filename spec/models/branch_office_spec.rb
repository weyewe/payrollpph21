require 'rails_helper'

RSpec.describe BranchOffice, type: :model do
  before (:each) do
      @office = Office.create_object(
            :code => "SSD",
            :name => "Solusi Sentral Data"
          )
  end
  
  it "should allow object creation with code and name" do
    code = "SSDSUB"
    branch_office = BranchOffice.create_object(
        :office_id => @office.id,
        :code => code,
        :name => "Solusi Sentral Data - Surabaya"
      )
      
    branch_office.should be_valid
    
    branch_office.code.should == code
  end
  
  it "should not allow object creation without office id" do
    code = "SSDSUB"
    branch_office = BranchOffice.create_object( 
        :office_id => "",
        :code => code,
        :name => "Solusi Sentral Data"
      )
      
    branch_office.should_not be_valid
  end
  
  it "should not allow object creation with invalid office id" do
    code = "SSDSUB"
    branch_office = BranchOffice.create_object( 
        :office_id => 0,
        :code => code,
        :name => "Solusi Sentral Data"
      )
      
    branch_office.should_not be_valid
  end
  
  it "should not allow object creation without name" do
    code = "SSDSUB"
    branch_office = BranchOffice.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => ""
      )
      
    branch_office.should_not be_valid
  end
  
  it "should not allow object creation without code" do
    code = "SSDSUB"
    branch_office = BranchOffice.create_object( 
        :office_id => @office.id,
        :code => "",
        :name => "Solusi Sentral Data"
      )
      
    branch_office.should_not be_valid
  end
  
  it "should not allow object creation with duplicate code" do
    code = "SSDSUB"
    branch_office =  BranchOffice.create_object( 
        :office_id => @office.id,
        :code =>  code,
        :name => "Solusi Sentral Data - Surabaya"
      )
      
    branch_office.should be_valid
    
    branch_office_2 = BranchOffice.create_object( 
        :office_id => @office.id,
        :code =>  code,
        :name => "Solusi Sentral Data - Jakarta"
      )
      
    branch_office_2.should_not be_valid
  end
  
  context "has been created branch_office" do
    before(:each) do
      @branch_office_1_code = "SSDSUB"
      @branch_office_1_name = "Solusi Sentral Data - Surabaya"
      @branch_office = BranchOffice.create_object(
          :office_id => @office.id,
          :code =>  @branch_office_1_code,
          :name =>  @branch_office_1_name
        )
        
      @branch_office_2_code = "SSDJKT"
      @branch_office_2_name = "Solusi Sentral Data - Jakarta"
      @branch_office_2 = BranchOffice.create_object(
          :office_id => @office.id,
          :code => @branch_office_2_code,
          :name => @branch_office_2_name
        )
    end
    
    it "should have 2 objects" do
      BranchOffice.count.should == 2 
    end
    
    it "should create valid objects" do
      @branch_office.should be_valid
      @branch_office_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_code = "SSDBL"
      new_name = "Solusi Sentral Data - Bali"
      
      @branch_office.update_object(
          :office_id => @office.id,
          :code => new_code,
          :name => new_name
        )
        
      @branch_office.should be_valid
      
      @branch_office.reload 
      
      @branch_office.name.should == new_name
      @branch_office.code.should == new_code
    end
    
    it "should not allow duplicate code" do
      @branch_office_2.update_object(
          :office_id => @office.id,
          :code => @branch_office_1_code,
          :name => @branch_office_2_name
        )
        
      @branch_office_2.errors.size.should_not == 0 
      @branch_office_2.should_not be_valid
    end
    
    it "should be allowed to delete object 2" do
      @branch_office_2.delete_object
      
      @branch_office_2.persisted?.should be_falsy  # be_truthy 
      
      BranchOffice.count.should == 1 
    end
  end
end
