require 'rails_helper'

RSpec.describe Bank, type: :model do
  before (:each) do
      @office = Office.create_object(
            :code => "SSD",
            :name => "Solusi Sentral Data"
          )
  end
  
  it "should allow object creation with code and name" do
    code = "BCA"
    bank = Bank.create_object(
        :office_id => @office.id,
        :code => code,
        :name => "Bank Central Asia"
      )
      
    bank.should be_valid
    
    bank.code.should == code
  end
  
  it "should not allow object creation without office id" do
    code = "BCA"
    bank = Bank.create_object( 
        :office_id => "",
        :code => code,
        :name => "Bank Central Asia"
      )
      
    bank.should_not be_valid
  end
  
  it "should not allow object creation with invalid office id" do
    code = "BCA"
    bank = Bank.create_object( 
        :office_id => 0,
        :code => code,
        :name => "Bank Central Asia"
      )
      
    bank.should_not be_valid
  end
  
  it "should not allow object creation without name" do
    code = "BCA"
    bank = Bank.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => ""
      )
      
    bank.should_not be_valid
  end
  
  it "should not allow object creation without code" do
    code = "BCA"
    bank = Bank.create_object( 
        :office_id => @office.id,
        :code => "",
        :name => "Bank Central Asia"
      )
      
    bank.should_not be_valid
  end
  
  it "should not allow object creation with duplicate code" do
    code = "BCA"
    bank =  Bank.create_object( 
        :office_id => @office.id,
        :code =>  code,
        :name => "Bank Central Asia"
      )
      
    bank.should be_valid
    
    bank_2 = Bank.create_object( 
        :office_id => @office.id,
        :code =>  code,
        :name => "Bank Central Asia Tbk"
      )
      
    bank_2.should_not be_valid
  end
  
  context "has been created bank" do
    before(:each) do
      @bank_1_code = "BCA"
      @bank_1_name = "Bank Central Asia"
      @bank = Bank.create_object(
          :office_id => @office.id,
          :code =>  @bank_1_code,
          :name =>  @bank_1_name
        )
        
      @bank_2_code = "BNI"
      @bank_2_name = "Bank Nasional Indonesia"
      @bank_2 = Bank.create_object(
          :office_id => @office.id,
          :code => @bank_2_code,
          :name => @bank_2_name
        )
    end
    
    it "should have 2 objects" do
      Bank.count.should == 2 
    end
    
    it "should create valid objects" do
      @bank.should be_valid
      @bank_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_code = "BRI"
      new_name = "Bank Rakyat Indonesia"
      
      @bank.update_object(
          :office_id => @office.id,
          :code => new_code,
          :name => new_name
        )
        
      @bank.should be_valid
      
      @bank.reload 
      
      @bank.name.should == new_name
      @bank.code.should == new_code
    end
    
    it "should not allow duplicate code" do
      @bank_2.update_object(
          :office_id => @office.id,
          :code => @bank_1_code,
          :name => @bank_2_name
        )
        
      @bank_2.errors.size.should_not == 0 
      @bank_2.should_not be_valid
    end
    
    it "should be allowed to delete object 2" do
      @bank_2.delete_object
      
      @bank_2.persisted?.should be_falsy  # be_truthy 
      
      Bank.count.should == 1 
    end
  end
end
