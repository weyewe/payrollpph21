require 'rails_helper'

RSpec.describe DayOff, type: :model do
  before (:each) do
      @office = Office.create_object(
            :code => "SSD",
            :name => "Solusi Sentral Data"
          )
          
      @overtime = Overtime.create_object(
            :office_id => @office.id,
            :code => "HK",
            :name => "Overtime di Hari Kerja"
          )
  end
  
  it "should allow object creation with code and name" do
    date = DateTime.new(2015,06,02)
    day_off = DayOff.create_object(
        :office_id => @office.id,
        :overtime_id => @overtime.id,
        :date => date
      )
      
    day_off.should be_valid
    
    day_off.date.should == date
  end
  
  it "should not allow object creation without office id" do
    date = DateTime.new(2015,06,02)
    day_off = DayOff.create_object( 
        :office_id => "",
        :overtime_id => @overtime.id,
        :date => date
      )
      
    day_off.should_not be_valid
  end
  
  it "should not allow object creation with invalid office id" do
    date = DateTime.new(2015,06,02)
    day_off = DayOff.create_object( 
        :office_id => 0,
        :overtime_id => @overtime.id,
        :date => date
      )
      
    day_off.should_not be_valid
  end
  
  it "should not allow object creation without overtime id" do
    date = DateTime.new(2015,06,02)
    day_off = DayOff.create_object( 
        :office_id => @office.id,
        :overtime_id => "",
        :date => date
      )
      
    day_off.should_not be_valid
  end
  
  it "should not allow object creation with invalid office id" do
    date = DateTime.new(2015,06,02)
    day_off = DayOff.create_object( 
        :office_id => @office.id,
        :overtime_id => 0,
        :date => date
      )
      
    day_off.should_not be_valid
  end
  
  it "should not allow object creation without date" do
    date = DateTime.new(2015,06,02)
    day_off = DayOff.create_object( 
        :office_id => @office.id,
        :overtime_id => @overtime.id,
        :date => ""
      )
      
    day_off.should_not be_valid
  end
  
  it "should not allow object creation with duplicate code" do
    date = DateTime.new(2015,06,02)
    day_off =  DayOff.create_object( 
        :office_id => @office.id,
        :overtime_id => @overtime.id,
        :date => date
      )
      
    day_off.should be_valid
    
    day_off_2 = DayOff.create_object( 
        :office_id => @office.id,
        :overtime_id => @overtime.id,
        :date => date
      )
      
    day_off_2.should_not be_valid
  end
  
  context "has been created day_off" do
    before(:each) do
      @day_off_1_date = DateTime.new(2015,06,02)
      @day_off = DayOff.create_object(
          :office_id => @office.id,
          :overtime_id =>  @overtime.id,
          :date =>  @day_off_1_date
        )
        
      @day_off_2_date = DateTime.new(2015,07,17)
      @day_off_2 = DayOff.create_object(
          :office_id => @office.id,
          :overtime_id =>  @overtime.id,
          :date =>  @day_off_2_date
        )
    end
    
    it "should have 2 objects" do
      DayOff.count.should == 2 
    end
    
    it "should create valid objects" do
      @day_off.should be_valid
      @day_off_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_date = DateTime.new(2015,07,18)
      
      @day_off.update_object(
          :office_id => @office.id,
          :overtime_id =>  @overtime.id,
          :date =>  new_date
        )
        
      @day_off.should be_valid
      
      @day_off.reload 
      
      @day_off.date.should == new_date
    end
    
    it "should not allow duplicate code" do
      @day_off_2.update_object(
          :office_id => @office.id,
          :overtime_id => @overtime.id,
          :date => @day_off_1_date
        )
        
      @day_off_2.errors.size.should_not == 0 
      @day_off_2.should_not be_valid
    end
    
    it "should be allowed to delete object 2" do
      @day_off_2.delete_object
      
      @day_off_2.persisted?.should be_falsy  # be_truthy 
      
      DayOff.count.should == 1 
    end
  end
end
