require 'rails_helper'

RSpec.describe Level, type: :model do
  before (:each) do
      @office = Office.create_object(
            :code => "SSD",
            :name => "Solusi Sentral Data"
          )
  end
  
  it "should allow object creation with code and name" do
    code = "STF"
    level = Level.create_object(
        :office_id => @office.id,
        :code => code,
        :name => "Staff"
      )
      
    level.should be_valid
    
    level.code.should == code
  end
  
  it "should not allow object creation without office id" do
    code = "STF"
    level = Level.create_object( 
        :office_id => "",
        :code => code,
        :name => "Staff"
      )
      
    level.should_not be_valid
  end
  
  it "should not allow object creation with invalid office id" do
    code = "STF"
    level = Level.create_object( 
        :office_id => 0,
        :code => code,
        :name => "Staff"
      )
      
    level.should_not be_valid
  end
  
  it "should not allow object creation without name" do
    code = "STF"
    level = Level.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => ""
      )
      
    level.should_not be_valid
  end
  
  it "should not allow object creation without code" do
    code = "STF"
    level = Level.create_object( 
        :office_id => @office.id,
        :code => "",
        :name => "Staff"
      )
      
    level.should_not be_valid
  end
  
  it "should not allow object creation with duplicate code" do
    code = "STF"
    level =  Level.create_object( 
        :office_id => @office.id,
        :code =>  code,
        :name => "Staff"
      )
      
    level.should be_valid
    
    level_2 = Level.create_object( 
        :office_id => @office.id,
        :code =>  code,
        :name => "Staff IT"
      )
      
    level_2.should_not be_valid
  end
  
  context "has been created level" do
    before(:each) do
      @level_1_code = "STF"
      @level_1_name = "Staff"
      @level = Level.create_object(
          :office_id => @office.id,
          :code =>  @level_1_code,
          :name =>  @level_1_name
        )
        
      @level_2_code = "SPV"
      @level_2_name = "Supervisor"
      @level_2 = Level.create_object(
          :office_id => @office.id,
          :code => @level_2_code,
          :name => @level_2_name
        )
    end
    
    it "should have 2 objects" do
      Level.count.should == 2 
    end
    
    it "should create valid objects" do
      @level.should be_valid
      @level_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_code = "MGR"
      new_name = "Manager"
      
      @level.update_object(
          :office_id => @office.id,
          :code => new_code,
          :name => new_name
        )
        
      @level.should be_valid
      
      @level.reload 
      
      @level.name.should == new_name
      @level.code.should == new_code
    end
    
    it "should not allow duplicate code" do
      @level_2.update_object(
          :office_id => @office.id,
          :code => @level_1_code,
          :name => @level_2_name
        )
        
      @level_2.errors.size.should_not == 0 
      @level_2.should_not be_valid
    end
    
    it "should be allowed to delete object 2" do
      @level_2.delete_object
      
      @level_2.persisted?.should be_falsy  # be_truthy 
      
      Level.count.should == 1 
    end
  end
end
