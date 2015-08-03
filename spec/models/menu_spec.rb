require 'rails_helper'

RSpec.describe Menu, type: :model do
  it "should allow object creation with code and name" do
    code = "MNU01"
    menu = Menu.create_object(
        :code => code,
        :name => "Master Bank"
      )
      
    menu.should be_valid
    
    menu.code.should == code
  end
  
  it "should not allow object creation without name" do
    code = "MNU01"
    menu = Menu.create_object( 
        :code => code,
        :name => ""
      )
      
    menu.should_not be_valid
  end
  
  it "should not allow object creation without code" do
    code = "MNU01"
    menu = Menu.create_object( 
        :code => "",
        :name => "Master Bank"
      )
      
    menu.should_not be_valid
  end
  
  it "should not allow object creation with duplicate code" do
    code = "MNU01"
    menu =  Menu.create_object( 
        :code =>  code,
        :name => "Master Bank"
      )
      
    menu.should be_valid
    
    menu_2 = Menu.create_object( 
        :code =>  code,
        :name => "Master Bank"
      )
      
    menu_2.should_not be_valid
  end
  
  context "has been created menu" do
    before(:each) do
      @menu_1_code = "MNU01"
      @menu_1_name = "Master Bank"
      @menu = Menu.create_object(
          :code =>  @menu_1_code,
          :name =>  @menu_1_name
        )
        
      @menu_2_code = "MNU02"
      @menu_2_name = "Master Company"
      @menu_2 = Menu.create_object(
          :code => @menu_2_code,
          :name => @menu_2_name
        )
    end
    
    it "should have 2 objects" do
      Menu.count.should == 2 
    end
    
    it "should create valid objects" do
      @menu.should be_valid
      @menu_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_code = "MNU03"
      new_name = "Master Branch Office"
      
      @menu.update_object(
          :code => new_code,
          :name => new_name
        )
        
      @menu.should be_valid
      
      @menu.reload 
      
      @menu.name.should == new_name
      @menu.code.should == new_code
    end
    
    it "should not allow duplicate code" do
      @menu_2.update_object(
          :code => @menu_1_code,
          :name => @menu_2_name
        )
        
      @menu_2.errors.size.should_not == 0 
      @menu_2.should_not be_valid
    end
    
    it "should be allowed to delete object 2" do
      @menu_2.delete_object
      
      @menu_2.persisted?.should be_falsy  # be_truthy 
      
      Menu.count.should == 1 
    end
  end
end
