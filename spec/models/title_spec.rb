require 'rails_helper'

RSpec.describe Title, type: :model do
  before (:each) do
      @office = Office.create_object(
            :code => "SSD",
            :name => "Solusi Sentral Data"
          )
  end
  
  it "should allow object creation with code and name" do
    code = "JPROG"
    title = Title.create_object(
        :office_id => @office.id,
        :code => code,
        :name => "Junior Programmer"
      )
      
    title.should be_valid
    
    title.code.should == code
  end
  
  it "should not allow object creation without office id" do
    code = "JPROG"
    title = Title.create_object( 
        :office_id => "",
        :code => code,
        :name => "Junior Programmer"
      )
      
    title.should_not be_valid
  end
  
  it "should not allow object creation with invalid office id" do
    code = "JPROG"
    title = Title.create_object( 
        :office_id => 0,
        :code => code,
        :name => "Junior Programmer"
      )
      
    title.should_not be_valid
  end
  
  it "should not allow object creation without name" do
    code = "JPROG"
    title = Title.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => ""
      )
      
    title.should_not be_valid
  end
  
  it "should not allow object creation without code" do
    code = "JPROG"
    title = Title.create_object( 
        :office_id => @office.id,
        :code => "",
        :name => "Junior Programmer"
      )
      
    title.should_not be_valid
  end
  
  it "should not allow object creation with duplicate code" do
    code = "JPROG"
    title =  Title.create_object( 
        :office_id => @office.id,
        :code =>  code,
        :name => "Junior Programmer"
      )
      
    title.should be_valid
    
    title_2 = Title.create_object( 
        :office_id => @office.id,
        :code =>  code,
        :name => "Senior Programmer"
      )
      
    title_2.should_not be_valid
  end
  
  context "has been created title" do
    before(:each) do
      @title_1_code = "JPROG"
      @title_1_name = "Junior Programmer"
      @title = Title.create_object(
          :office_id => @office.id,
          :code =>  @title_1_code,
          :name =>  @title_1_name
        )
        
      @title_2_code = "SPROG"
      @title_2_name = "Senior Programmer"
      @title_2 = Title.create_object(
          :office_id => @office.id,
          :code => @title_2_code,
          :name => @title_2_name
        )
    end
    
    it "should have 2 objects" do
      Title.count.should == 2 
    end
    
    it "should create valid objects" do
      @title.should be_valid
      @title_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_code = "MKT"
      new_name = "Marketing"
      
      @title.update_object(
          :office_id => @office.id,
          :code => new_code,
          :name => new_name
        )
        
      @title.should be_valid
      
      @title.reload 
      
      @title.name.should == new_name
      @title.code.should == new_code
    end
    
    it "should not allow duplicate code" do
      @title_2.update_object(
          :office_id => @office.id,
          :code => @title_1_code,
          :name => @title_2_name
        )
        
      @title_2.errors.size.should_not == 0 
      @title_2.should_not be_valid
    end
    
    it "should be allowed to delete object 2" do
      @title_2.delete_object
      
      @title_2.persisted?.should be_falsy  # be_truthy 
      
      Title.count.should == 1 
    end
  end
end
