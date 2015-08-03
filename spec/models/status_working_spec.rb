require 'rails_helper'

RSpec.describe StatusWorking, type: :model do
  before (:each) do
      @office = Office.create_object(
            :code => "SSD",
            :name => "Solusi Sentral Data"
          )
  end
  
  it "should allow object creation with code and name" do
    code = "PMT"
    status_working = StatusWorking.create_object(
        :office_id => @office.id,
        :code => code,
        :name => "Permanent",
        :is_contract => false
      )
      
    status_working.should be_valid
    
    status_working.code.should == code
  end
  
  it "should not allow object creation without office id" do
    code = "PMT"
    status_working = StatusWorking.create_object( 
        :office_id => "",
        :code => code,
        :name => "Permanent",
        :is_contract => false
      )
      
    status_working.should_not be_valid
  end
  
  it "should not allow object creation with invalid office id" do
    code = "PMT"
    status_working = StatusWorking.create_object( 
        :office_id => 0,
        :code => code,
        :name => "Permanent",
        :is_contract => false
      )
      
    status_working.should_not be_valid
  end
  
  it "should not allow object creation without name" do
    code = "PMT"
    status_working = StatusWorking.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => "",
        :is_contract => false
      )
      
    status_working.should_not be_valid
  end
  
  it "should not allow object creation without code" do
    code = "PMT"
    status_working = StatusWorking.create_object( 
        :office_id => @office.id,
        :code => "",
        :name => "Permanent",
        :is_contract => false
      )
      
    status_working.should_not be_valid
  end
  
  it "should not allow object creation with duplicate code" do
    code = "PMT"
    status_working =  StatusWorking.create_object( 
        :office_id => @office.id,
        :code =>  code,
        :name => "Permanent",
        :is_contract => false
      )
      
    status_working.should be_valid
    
    status_working_2 = StatusWorking.create_object( 
        :office_id => @office.id,
        :code =>  code,
        :name => "Permanent Staff",
        :is_contract => false
      )
      
    status_working_2.should_not be_valid
  end
  
  context "has been created working status" do
    before(:each) do
      @status_working_1_code = "PMT"
      @status_working_1_name = "Permanent"
      @status_working = StatusWorking.create_object(
          :office_id => @office.id,
          :code =>  @status_working_1_code,
          :name =>  @status_working_1_name,
          :is_contract => false
        )
        
      @status_working_2_code = "CTR"
      @status_working_2_name = "Contract"
      @status_working_2 = StatusWorking.create_object(
          :office_id => @office.id,
          :code => @status_working_2_code,
          :name => @status_working_2_name,
          :is_contract => true
        )
    end
    
    it "should have 2 objects" do
      StatusWorking.count.should == 2 
    end
    
    it "should create valid objects" do
      @status_working.should be_valid
      @status_working_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_code = "PRB"
      new_name = "Probation"
      
      @status_working.update_object(
          :office_id => @office.id,
          :code => new_code,
          :name => new_name,
          :is_contract => true
        )
        
      @status_working.should be_valid
      
      @status_working.reload 
      
      @status_working.name.should == new_name
      @status_working.code.should == new_code
    end
    
    it "should not allow duplicate code" do
      @status_working_2.update_object(
          :office_id => @office.id,
          :code => @status_working_1_code,
          :name => @status_working_2_name,
          :is_contract => false
        )
        
      @status_working_2.errors.size.should_not == 0 
      @status_working_2.should_not be_valid
    end
    
    it "should be allowed to delete object 2" do
      @status_working_2.delete_object
      
      @status_working_2.persisted?.should be_falsy  # be_truthy 
      
      StatusWorking.count.should == 1 
    end
  end
end
