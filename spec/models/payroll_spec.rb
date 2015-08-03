require 'rails_helper'

RSpec.describe Payroll, type: :model do
  before (:each) do
      @office = Office.create_object(
            :code => "SSD",
            :name => "Solusi Sentral Data"
          )
    
      @office_2 = Office.create_object(
            :code => "FE",
            :name => "Freight Express"
          )
  end
  
  it "should allow object creation with all required field" do
    payroll = Payroll.create_object(
        :office_id => @office.id,
        :month => DateTime.new(2015,1,1),
        :start_date => DateTime.new(2015,1,1),
        :end_date => DateTime.new(2015,1,31)
      )
      
    payroll.should be_valid
  end
  
  it "should not allow object creation without office id" do
    payroll = Payroll.create_object( 
        :office_id => "",
        :month => DateTime.new(2015,1,1),
        :start_date => DateTime.new(2015,1,1),
        :end_date => DateTime.new(2015,1,31)
      )
      
    payroll.should_not be_valid
  end
  
  it "should not allow object creation with invalid office id" do
    payroll = Payroll.create_object( 
        :office_id => 0,
        :month => DateTime.new(2015,1,1),
        :start_date => DateTime.new(2015,1,1),
        :end_date => DateTime.new(2015,1,31)
      )
      
    payroll.should_not be_valid
  end
  
  it "should not allow object creation without month" do
    payroll = Payroll.create_object( 
        :office_id => @office.id,
        :month => "",
        :start_date => DateTime.new(2015,1,1),
        :end_date => DateTime.new(2015,1,31)
      )
      
    payroll.should_not be_valid
  end
  
  it "should not allow object creation without start_date" do
    payroll = Payroll.create_object( 
        :office_id => @office.id,
        :month => DateTime.new(2015,1,1),
        :start_date => "",
        :end_date => DateTime.new(2015,1,31)
      )
      
    payroll.should_not be_valid
  end
  
  it "should not allow object creation without end_date" do
    payroll = Payroll.create_object( 
        :office_id => @office.id,
        :month => DateTime.new(2015,1,1),
        :start_date => DateTime.new(2015,1,1),
        :end_date =>""
      )
      
    payroll.should_not be_valid
  end
  
  context "has been created payroll" do
    before(:each) do
      @payroll = Payroll.create_object(
          :office_id => @office.id,
          :month => DateTime.new(2015,1,1),
          :start_date => DateTime.new(2015,1,1),
          :end_date => DateTime.new(2015,1,31)
        )
        
      @payroll_2 = Payroll.create_object(
          :office_id => @office_2.id,
          :month => DateTime.new(2015,1,1),
          :start_date => DateTime.new(2015,1,1),
          :end_date => DateTime.new(2015,1,31)
        )
    end
    
    it "should have 2 objects" do
      Payroll.count.should == 2 
    end
    
    it "should create valid objects" do
      @payroll.should be_valid
      @payroll_2.should be_valid
    end
    
    it "should be allowed to delete object 2" do
      @payroll_2.delete_object
      
      @payroll_2.persisted?.should be_falsy  # be_truthy 
      
      Payroll.count.should == 1 
    end
  end
end
