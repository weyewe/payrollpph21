require 'rails_helper'

RSpec.describe Ptkp, type: :model do
  before (:each) do
      @office = Office.create_object(
            :code => "SSD",
            :name => "Solusi Sentral Data"
          )
  end
  
  it "should allow object creation with code and name" do
    code = "PTKP2008"
    ptkp = Ptkp.create_object(
        :office_id => @office.id,
        :code => code,
        :name => "PTKP Aturan Tahun 2008"
      )
      
    ptkp.should be_valid
    
    ptkp.code.should == code
  end
  
  it "should not allow object creation without office id" do
    code = "PTKP2008"
    ptkp = Ptkp.create_object( 
        :office_id => "",
        :code => code,
        :name => "PTKP Aturan Tahun 2008"
      )
      
    ptkp.should_not be_valid
  end
  
  it "should not allow object creation with invalid office id" do
    code = "PTKP2008"
    ptkp = Ptkp.create_object( 
        :office_id => 0,
        :code => code,
        :name => "PTKP Aturan Tahun 2008"
      )
      
    ptkp.should_not be_valid
  end
  
  it "should not allow object creation without name" do
    code = "PTKP2008"
    ptkp = Ptkp.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => ""
      )
      
    ptkp.should_not be_valid
  end
  
  it "should not allow object creation without code" do
    code = "PTKP2008"
    ptkp = Ptkp.create_object( 
        :office_id => @office.id,
        :code => "",
        :name => "PTKP Aturan Tahun 2008"
      )
      
    ptkp.should_not be_valid
  end
  
  it "should not allow object creation with duplicate code" do
    code = "PTKP2008"
    ptkp =  Ptkp.create_object( 
        :office_id => @office.id,
        :code =>  code,
        :name => "PTKP Aturan Tahun 2008"
      )
      
    ptkp.should be_valid
    
    ptkp_2 = Ptkp.create_object( 
        :office_id => @office.id,
        :code =>  code,
        :name => "PTKP Aturan Tahun 2008 Tbk"
      )
      
    ptkp_2.should_not be_valid
  end
  
  context "has been created ptkp" do
    before(:each) do
      @ptkp_1_code = "PTKP2008"
      @ptkp_1_name = "PTKP Aturan Tahun 2008"
      @ptkp = Ptkp.create_object(
          :office_id => @office.id,
          :code =>  @ptkp_1_code,
          :name =>  @ptkp_1_name
        )
        
      @ptkp_2_code = "PTKP2013"
      @ptkp_2_name = "PTKP Aturan Tahun 2013"
      @ptkp_2 = Ptkp.create_object(
          :office_id => @office.id,
          :code => @ptkp_2_code,
          :name => @ptkp_2_name
        )
    end
    
    it "should have 2 objects" do
      Ptkp.count.should == 2 
    end
    
    it "should create valid objects" do
      @ptkp.should be_valid
      @ptkp_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_code = "PTKP2020"
      new_name = "PTKP Aturan Tahun 2020"
      
      @ptkp.update_object(
          :office_id => @office.id,
          :code => new_code,
          :name => new_name
        )
        
      @ptkp.should be_valid
      
      @ptkp.reload 
      
      @ptkp.name.should == new_name
      @ptkp.code.should == new_code
    end
    
    it "should not allow duplicate code" do
      @ptkp_2.update_object(
          :office_id => @office.id,
          :code => @ptkp_1_code,
          :name => @ptkp_2_name
        )
        
      @ptkp_2.errors.size.should_not == 0 
      @ptkp_2.should_not be_valid
    end
    
    it "should be allowed to delete object 2" do
      @ptkp_2.delete_object
      
      @ptkp_2.persisted?.should be_falsy  # be_truthy 
      
      Ptkp.count.should == 1 
    end
  end
end
