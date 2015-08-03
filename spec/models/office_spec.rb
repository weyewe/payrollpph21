require 'rails_helper'

RSpec.describe Office, type: :model do
  it "should allow object creation with code and name" do
    code = "SSD"
    office = Office.create_object( 
        :code => code,
        :name => "Solusi Sentral Data"
      )
      
    office.should be_valid
    
    office.code.should == code
  end
  
  it "should not allow object creation without name" do
    code = "SSD"
    office = Office.create_object( 
        :code => code,
        :name => "",
      )
      
    office.should_not be_valid
  end
  
  it "should not allow object creation without code" do
    code = "SSD"
    office = Office.create_object( 
        :code => "",
        :name => "Solusi Sentral Data",
      )
      
    office.should_not be_valid
  end
  
  it "should not allow object creation with duplicate code" do
    code = "SSD"
    office =  Office.create_object( 
        :code =>  code,
        :name => "Solusi Sentral Data"
      )
      
    office.should be_valid
    
    office_2 =  Office.create_object( 
        :code =>  code,
        :name => "Solusi Sentral Data Surabaya"
      )
      
    office_2.should_not be_valid
  end
  
  context "has been created office" do
    before(:each) do
      @office_1_code = "SSD"
      @office_1_name = "Solusi Sentral Dat"
      @office = Office.create_object(
          :code =>  @office_1_code,
          :name =>  @office_1_name
        )
        
      @office_2_code = "FE"
      @office_2_name = "Freight Express"
      @office_2 = Office.create_object(
          :code => @office_2_code,
          :name => @office_2_name
        )
    end
    
    it "should have 2 objects" do
      Office.count.should == 2 
    end
    
    it "should create valid objects" do
      @office.should be_valid
      @office_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_code = "SSDSUB"
      new_name = "Solusi Sentral Data - Surabaya"
      
      @office.update_object(
          :code => new_code,
          :name => new_name
        )
        
      @office.should be_valid
      
      @office.reload 
      
      @office.name.should == new_name
      @office.code.should == new_code
    end
    
    it "should not allow duplicate code" do
      @office_2.update_object(
          :code => @office_1_code,
          :name => @office_2_name
        )
        
      @office_2.errors.size.should_not == 0 
      @office_2.should_not be_valid
    end
    
    it "should be allowed to delete object 2" do
      @office_2.delete_object
      
      @office_2.persisted?.should be_falsy  # be_truthy 
      
      Office.count.should == 1 
    end
  end
end
