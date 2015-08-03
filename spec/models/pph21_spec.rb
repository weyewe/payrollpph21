require 'rails_helper'

RSpec.describe Pph21, type: :model do
  before (:each) do
      @office = Office.create_object(
            :code => "SSD",
            :name => "Solusi Sentral Data"
          )
  end
  
  it "should allow object creation with code and name" do
    code = "PPh212008"
    pph21 = Pph21.create_object(
        :office_id => @office.id,
        :code => code,
        :name => "PPh21 Aturan Tahun 2008"
      )
      
    pph21.should be_valid
    
    pph21.code.should == code
  end
  
  it "should not allow object creation without office id" do
    code = "PPh212008"
    pph21 = Pph21.create_object( 
        :office_id => "",
        :code => code,
        :name => "PPh21 Aturan Tahun 2008"
      )
      
    pph21.should_not be_valid
  end
  
  it "should not allow object creation with invalid office id" do
    code = "PPh212008"
    pph21 = Pph21.create_object( 
        :office_id => 0,
        :code => code,
        :name => "PPh21 Aturan Tahun 2008"
      )
      
    pph21.should_not be_valid
  end
  
  it "should not allow object creation without name" do
    code = "PPh212008"
    pph21 = Pph21.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => ""
      )
      
    pph21.should_not be_valid
  end
  
  it "should not allow object creation without code" do
    code = "PPh212008"
    pph21 = Pph21.create_object( 
        :office_id => @office.id,
        :code => "",
        :name => "PPh21 Aturan Tahun 2008"
      )
      
    pph21.should_not be_valid
  end
  
  it "should not allow object creation with duplicate code" do
    code = "PPh212008"
    pph21 =  Pph21.create_object( 
        :office_id => @office.id,
        :code =>  code,
        :name => "PPh21 Aturan Tahun 2008"
      )
      
    pph21.should be_valid
    
    pph21_2 = Pph21.create_object( 
        :office_id => @office.id,
        :code =>  code,
        :name => "PPh21 Aturan Tahun 2008 Tbk"
      )
      
    pph21_2.should_not be_valid
  end
  
  context "has been created pph21" do
    before(:each) do
      @pph21_1_code = "PPh212008"
      @pph21_1_name = "PPh21 Aturan Tahun 2008"
      @pph21 = Pph21.create_object(
          :office_id => @office.id,
          :code =>  @pph21_1_code,
          :name =>  @pph21_1_name
        )
        
      @pph21_2_code = "PPh212013"
      @pph21_2_name = "PPh21 Aturan Tahun 2013"
      @pph21_2 = Pph21.create_object(
          :office_id => @office.id,
          :code => @pph21_2_code,
          :name => @pph21_2_name
        )
    end
    
    it "should have 2 objects" do
      Pph21.count.should == 2 
    end
    
    it "should create valid objects" do
      @pph21.should be_valid
      @pph21_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_code = "PPh212020"
      new_name = "PPh21 Aturan Tahun 2020"
      
      @pph21.update_object(
          :office_id => @office.id,
          :code => new_code,
          :name => new_name
        )
        
      @pph21.should be_valid
      
      @pph21.reload 
      
      @pph21.name.should == new_name
      @pph21.code.should == new_code
    end
    
    it "should not allow duplicate code" do
      @pph21_2.update_object(
          :office_id => @office.id,
          :code => @pph21_1_code,
          :name => @pph21_2_name
        )
        
      @pph21_2.errors.size.should_not == 0 
      @pph21_2.should_not be_valid
    end
    
    it "should be allowed to delete object 2" do
      @pph21_2.delete_object
      
      @pph21_2.persisted?.should be_falsy  # be_truthy 
      
      Pph21.count.should == 1 
    end
  end
end
