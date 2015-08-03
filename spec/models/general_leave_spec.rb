require 'rails_helper'

RSpec.describe GeneralLeave, type: :model do
  before (:each) do
      @office = Office.create_object(
            :code => "SSD",
            :name => "Solusi Sentral Data"
          )
      
      
  end
  
  it "should allow object creation with all required field" do
    date = DateTime.new(2015,8,17)
    general_leave = GeneralLeave.create_object(
        :office_id => @office.id,
        :date => date,
        :description => "Hari Kemerdekaan"
      )
      
    general_leave.should be_valid
    
    general_leave.date.should == date
  end
  
  it "should not allow object creation without office id" do
    date = DateTime.new(2015,8,17)
    general_leave = GeneralLeave.create_object( 
        :office_id => "",
        :date => date,
        :description => "Hari Kemerdekaan"
      )
      
    general_leave.should_not be_valid
  end
  
  it "should not allow object creation with invalid office id" do
    date = DateTime.new(2015,8,17)
    general_leave = GeneralLeave.create_object( 
        :office_id => 0,
        :date => date,
        :description => "Hari Kemerdekaan"
      )
      
    general_leave.should_not be_valid
  end
  
  it "should not allow object creation without description" do
    date = DateTime.new(2015,8,17)
    general_leave = GeneralLeave.create_object( 
        :office_id => @office.id,
        :date => date,
        :description => ""
      )
      
    general_leave.should_not be_valid
  end
  
  it "should not allow object creation without date" do
    date = DateTime.new(2015,8,17)
    general_leave = GeneralLeave.create_object( 
        :office_id => @office.id,
        :date => "",
        :description => "Hari Kemerdekaan"
      )
      
    general_leave.should_not be_valid
  end
  
  it "should not allow object creation with duplicate date" do
    date = DateTime.new(2015,8,17)
    general_leave =  GeneralLeave.create_object( 
        :office_id => @office.id,
        :date =>  date,
        :description => "Hari Kemerdekaan"
      )
      
    general_leave.should be_valid
    
    general_leave_2 = GeneralLeave.create_object( 
        :office_id => @office.id,
        :date =>  date,
        :description => "Hari Kemerdekaan Tbk"
      )
      
    general_leave_2.should_not be_valid
  end
  
  context "has been created general_leave" do
    before(:each) do
      @general_leave_1_date = DateTime.new(2015,8,17)
      @general_leave_1_description = "Hari Kemerdekaan"
      @general_leave = GeneralLeave.create_object(
          :office_id => @office.id,
          :date =>  @general_leave_1_date,
          :description =>  @general_leave_1_description
        )
        
      @general_leave_2_date = DateTime.new(2015,7,17)
      @general_leave_2_description = "Idul Fitri"
      @general_leave_2 = GeneralLeave.create_object(
          :office_id => @office.id,
          :date => @general_leave_2_date,
          :description => @general_leave_2_description
        )
    end
    
    it "should have 2 objects" do
      GeneralLeave.count.should == 2 
    end
    
    it "should create valid objects" do
      @general_leave.should be_valid
      @general_leave_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_date = DateTime.new(2015,8,18)
      new_description = "Idul Fitri"
      
      @general_leave.update_object(
          :office_id => @office.id,
          :date => new_date,
          :description => new_description
        )
        
      @general_leave.should be_valid
      
      @general_leave.reload 
      
      @general_leave.description.should == new_description
      @general_leave.date.should == new_date
    end
    
    it "should not allow duplicate date" do
      @general_leave_2.update_object(
          :office_id => @office.id,
          :date => @general_leave_1_date,
          :description => @general_leave_2_description
        )
        
      @general_leave_2.errors.size.should_not == 0 
      @general_leave_2.should_not be_valid
    end
    
    it "should be allowed to delete object 2" do
      @general_leave_2.delete_object
      
      @general_leave_2.persisted?.should be_falsy  # be_truthy 
      
      GeneralLeave.count.should == 1 
    end
  end
end
