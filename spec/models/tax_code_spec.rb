require 'rails_helper'

RSpec.describe TaxCode, type: :model do
  before (:each) do
      @office = Office.create_object(
            :code => "SSD",
            :name => "Solusi Sentral Data"
          )
  end
  
  it "should allow object creation with code and name" do
    code = "21-100-01"
    tax_code = TaxCode.create_object(
        :office_id => @office.id,
        :code => code,
        :name => "Pegawai Tetap"
      )
      
    tax_code.should be_valid
    
    tax_code.code.should == code
  end
  
  it "should not allow object creation without office id" do
    code = "21-100-01"
    tax_code = TaxCode.create_object( 
        :office_id => "",
        :code => code,
        :name => "Pegawai Tetap"
      )
      
    tax_code.should_not be_valid
  end
  
  it "should not allow object creation with invalid office id" do
    code = "21-100-01"
    tax_code = TaxCode.create_object( 
        :office_id => 0,
        :code => code,
        :name => "Pegawai Tetap"
      )
      
    tax_code.should_not be_valid
  end
  
  it "should not allow object creation without name" do
    code = "21-100-01"
    tax_code = TaxCode.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => ""
      )
      
    tax_code.should_not be_valid
  end
  
  it "should not allow object creation without code" do
    code = "21-100-01"
    tax_code = TaxCode.create_object( 
        :office_id => @office.id,
        :code => "",
        :name => "Pegawai Tetap"
      )
      
    tax_code.should_not be_valid
  end
  
  it "should not allow object creation with duplicate code" do
    code = "21-100-01"
    tax_code =  TaxCode.create_object( 
        :office_id => @office.id,
        :code =>  code,
        :name => "Pegawai Tetap"
      )
      
    tax_code.should be_valid
    
    tax_code_2 = TaxCode.create_object( 
        :office_id => @office.id,
        :code =>  code,
        :name => "Kode Pajak Untuk Pegawai Tetap"
      )
      
    tax_code_2.should_not be_valid
  end
  
  context "has been created tax_code" do
    before(:each) do
      @tax_code_1_code = "21-100-01"
      @tax_code_1_name = "Pegawai Tetap"
      @tax_code = TaxCode.create_object(
          :office_id => @office.id,
          :code =>  @tax_code_1_code,
          :name =>  @tax_code_1_name
        )
        
      @tax_code_2_code = "21-100-03"
      @tax_code_2_name = "Upah Pegawai Tidak Tetap atau Tenaga Kerja Lepas"
      @tax_code_2 = TaxCode.create_object(
          :office_id => @office.id,
          :code => @tax_code_2_code,
          :name => @tax_code_2_name
        )
    end
    
    it "should have 2 objects" do
      TaxCode.count.should == 2 
    end
    
    it "should create valid objects" do
      @tax_code.should be_valid
      @tax_code_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_code = "21-100-07"
      new_name = "Imbalan Kepada Tenaga Ahli"
      
      @tax_code.update_object(
          :office_id => @office.id,
          :code => new_code,
          :name => new_name
        )
        
      @tax_code.should be_valid
      
      @tax_code.reload 
      
      @tax_code.name.should == new_name
      @tax_code.code.should == new_code
    end
    
    it "should not allow duplicate code" do
      @tax_code_2.update_object(
          :office_id => @office.id,
          :code => @tax_code_1_code,
          :name => @tax_code_2_name
        )
        
      @tax_code_2.errors.size.should_not == 0 
      @tax_code_2.should_not be_valid
    end
    
    it "should be allowed to delete object 2" do
      @tax_code_2.delete_object
      
      @tax_code_2.persisted?.should be_falsy  # be_truthy 
      
      TaxCode.count.should == 1 
    end
  end
end
