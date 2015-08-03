require 'rails_helper'

RSpec.describe Shift, type: :model do
  before (:each) do
      @office = Office.create_object(
            :code => "SSD",
            :name => "Solusi Sentral Data"
          )
  end
  
  it "should allow object creation with code and name" do
    code = "SFT"
    shift = Shift.create_object(
        :office_id => @office.id,
        :code => code,
        :name => "SHIFT",
        :start_time => 480,
        :duration => 8
      )
      
    shift.should be_valid
    
    shift.code.should == code
  end
  
  it "should not allow object creation without office id" do
    code = "SFT"
    shift = Shift.create_object( 
        :office_id => "",
        :code => code,
        :name => "Shift",
        :start_time => 480,
        :duration => 8
      )
      
    shift.should_not be_valid
  end
  
  it "should not allow object creation with invalid office id" do
    code = "SFT"
    shift = Shift.create_object( 
        :office_id => 0,
        :code => code,
        :name => "Shift",
        :start_time => 480,
        :duration => 8
      )
      
    shift.should_not be_valid
  end
  
  it "should not allow object creation without name" do
    code = "SFT"
    shift = Shift.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => "",
        :start_time => 480,
        :duration => 8
      )
      
    shift.should_not be_valid
  end
  
  it "should not allow object creation without code" do
    code = "SFT"
    shift = Shift.create_object( 
        :office_id => @office.id,
        :code => "",
        :name => "Shift",
        :start_time => 480,
        :duration => 8
      )
      
    shift.should_not be_valid
  end
  
  it "should allow object creation without start time" do
    code = "SFT"
    shift = Shift.create_object(
        :office_id => @office.id,
        :code => code,
        :name => "SHIFT",
        :start_time => "",
        :duration => 8
      )
      
    shift.should_not be_valid
  end
  
  it "should allow object creation with invalid start time" do
    code = "SFT"
    shift = Shift.create_object(
        :office_id => @office.id,
        :code => code,
        :name => "SHIFT",
        :start_time => -5,
        :duration => 8
      )
      
    shift.should_not be_valid
  end
  
  it "should allow object creation without duration" do
    code = "SFT"
    shift = Shift.create_object(
        :office_id => @office.id,
        :code => code,
        :name => "SHIFT",
        :start_time => 480,
        :duration => ""
      )
      
    shift.should_not be_valid
  end
  
  it "should allow object creation with invalid duration" do
    code = "SFT"
    shift = Shift.create_object(
        :office_id => @office.id,
        :code => code,
        :name => "SHIFT",
        :start_time => 480,
        :duration => 0
      )
      
    shift.should_not be_valid
  end
  
  it "should not allow object creation with duplicate code" do
    code = "SFT"
    shift =  Shift.create_object( 
        :office_id => @office.id,
        :code =>  code,
        :name => "Shift",
        :start_time => 480,
        :duration => 8
      )
      
    shift.should be_valid
    
    shift_2 = Shift.create_object( 
        :office_id => @office.id,
        :code =>  code,
        :name => "Shift Normal",
        :start_time => 480,
        :duration => 8
      )
      
    shift_2.should_not be_valid
  end
  
  context "has been created shift" do
    before(:each) do
      @shift_1_code = "SFT"
      @shift_1_name = "Shift"
      @shift = Shift.create_object(
          :office_id => @office.id,
          :code =>  @shift_1_code,
          :name =>  @shift_1_name,
          :start_time => 480,
          :duration => 8
        )
        
      @shift_2_code = "STF"
      @shift_2_name = "Shift Staff"
      @shift_2 = Shift.create_object(
          :office_id => @office.id,
          :code => @shift_2_code,
          :name => @shift_2_name,
          :start_time => 540,
          :duration => 8
        )
    end
    
    it "should have 2 objects" do
      Shift.count.should == 2 
    end
    
    it "should create valid objects" do
      @shift.should be_valid
      @shift_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_code = "BO"
      new_name = "Back Office"
      
      @shift.update_object(
          :office_id => @office.id,
          :code => new_code,
          :name => new_name,
          :start_time => 600,
          :duration => 8
        )
        
      @shift.should be_valid
      
      @shift.reload 
      
      @shift.name.should == new_name
      @shift.code.should == new_code
    end
    
    it "should not allow duplicate code" do
      @shift_2.update_object(
          :office_id => @office.id,
          :code => @shift_1_code,
          :name => @shift_2_name,
          :start_time => 480,
          :duration => 8
        )
        
      @shift_2.errors.size.should_not == 0 
      @shift_2.should_not be_valid
    end
    
    it "should be allowed to delete object 2" do
      @shift_2.delete_object
      
      @shift_2.persisted?.should be_falsy  # be_truthy 
      
      Shift.count.should == 1 
    end
  end
end
