require 'rails_helper'

RSpec.describe Overtime, type: :model do
  before (:each) do
      @office = Office.create_object(
            :code => "SSD",
            :name => "Solusi Sentral Data"
          )
  end
  
  it "should allow object creation with code and name" do
    code = "HK"
    overtime = Overtime.create_object(
        :office_id => @office.id,
        :code => code,
        :name => "Overtime di Hari Kerja"
      )
      
    overtime.should be_valid
    
    overtime.code.should == code
  end
  
  it "should not allow object creation without office id" do
    code = "HK"
    overtime = Overtime.create_object( 
        :office_id => "",
        :code => code,
        :name => "Overtime di Hari Kerja"
      )
      
    overtime.should_not be_valid
  end
  
  it "should not allow object creation with invalid office id" do
    code = "HK"
    overtime = Overtime.create_object( 
        :office_id => 0,
        :code => code,
        :name => "Overtime di Hari Kerja"
      )
      
    overtime.should_not be_valid
  end
  
  it "should not allow object creation without name" do
    code = "HK"
    overtime = Overtime.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => ""
      )
      
    overtime.should_not be_valid
  end
  
  it "should not allow object creation without code" do
    code = "HK"
    overtime = Overtime.create_object( 
        :office_id => @office.id,
        :code => "",
        :name => "Overtime di Hari Kerja"
      )
      
    overtime.should_not be_valid
  end
  
  it "should not allow object creation with duplicate code" do
    code = "HK"
    overtime =  Overtime.create_object( 
        :office_id => @office.id,
        :code =>  code,
        :name => "Overtime di Hari Kerja"
      )
      
    overtime.should be_valid
    
    overtime_2 = Overtime.create_object( 
        :office_id => @office.id,
        :code =>  code,
        :name => "Overtime di Hari Kerja Tbk"
      )
      
    overtime_2.should_not be_valid
  end
  
  context "has been created overtime" do
    before(:each) do
      @overtime_1_code = "HK"
      @overtime_1_name = "Overtime di Hari Kerja"
      @overtime = Overtime.create_object(
          :office_id => @office.id,
          :code =>  @overtime_1_code,
          :name =>  @overtime_1_name
        )
        
      @overtime_2_code = "HL"
      @overtime_2_name = "Overtime di Hari Libur"
      @overtime_2 = Overtime.create_object(
          :office_id => @office.id,
          :code => @overtime_2_code,
          :name => @overtime_2_name
        )
    end
    
    it "should have 2 objects" do
      Overtime.count.should == 2 
    end
    
    it "should create valid objects" do
      @overtime.should be_valid
      @overtime_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_code = "HLL"
      new_name = "Hari Libur Lebaran"
      
      @overtime.update_object(
          :office_id => @office.id,
          :code => new_code,
          :name => new_name
        )
        
      @overtime.should be_valid
      
      @overtime.reload 
      
      @overtime.name.should == new_name
      @overtime.code.should == new_code
    end
    
    it "should not allow duplicate code" do
      @overtime_2.update_object(
          :office_id => @office.id,
          :code => @overtime_1_code,
          :name => @overtime_2_name
        )
        
      @overtime_2.errors.size.should_not == 0 
      @overtime_2.should_not be_valid
    end
    
    it "should be allowed to delete object 2" do
      @overtime_2.delete_object
      
      @overtime_2.persisted?.should be_falsy  # be_truthy 
      
      Overtime.count.should == 1 
    end
  end
end
