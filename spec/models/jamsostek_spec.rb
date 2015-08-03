require 'rails_helper'

RSpec.describe Jamsostek, type: :model do
  before (:each) do
      @office = Office.create_object(
            :code => "SSD",
            :name => "Solusi Sentral Data"
          )
  end
  
  it "should allow object creation with code and name" do
    code = "JSTK2013"
    jamsostek = Jamsostek.create_object(
        :office_id => @office.id,
        :code => code,
        :name => "Jamsostek Aturan Tahun 2013",
        :jkk_percentage => 0.24,
        :jkm_percentage => 0.3,
        :jht_employee_percentage => 2,
        :jht_office_percentage => 3.7
      )
      
    jamsostek.should be_valid
    
    jamsostek.code.should == code
  end
  
  it "should not allow object creation without office id" do
    code = "JSTK2013"
    jamsostek = Jamsostek.create_object( 
        :office_id => "",
        :code => code,
        :name => "Jamsostek Aturan Tahun 2013",
        :jkk_percentage => 0.24,
        :jkm_percentage => 0.3,
        :jht_employee_percentage => 2,
        :jht_office_percentage => 3.7
      )
      
    jamsostek.should_not be_valid
  end
  
  it "should not allow object creation with invalid office id" do
    code = "JSTK2013"
    jamsostek = Jamsostek.create_object( 
        :office_id => 0,
        :code => code,
        :name => "Jamsostek Aturan Tahun 2013",
        :jkk_percentage => 0.24,
        :jkm_percentage => 0.3,
        :jht_employee_percentage => 2,
        :jht_office_percentage => 3.7
      )
      
    jamsostek.should_not be_valid
  end
  
  it "should not allow object creation without name" do
    code = "JSTK2013"
    jamsostek = Jamsostek.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => "",
        :jkk_percentage => 0.24,
        :jkm_percentage => 0.3,
        :jht_employee_percentage => 2,
        :jht_office_percentage => 3.7
      )
      
    jamsostek.should_not be_valid
  end
  
  it "should not allow object creation without code" do
    code = "JSTK2013"
    jamsostek = Jamsostek.create_object( 
        :office_id => @office.id,
        :code => "",
        :name => "Jamsostek Aturan Tahun 2013",
        :jkk_percentage => 0.24,
        :jkm_percentage => 0.3,
        :jht_employee_percentage => 2,
        :jht_office_percentage => 3.7
      )
      
    jamsostek.should_not be_valid
  end
  
  it "should not allow object creation without jkk percentage" do
    code = "JSTK2013"
    jamsostek = Jamsostek.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => "Jamsostek Aturan Tahun 2013",
        :jkk_percentage => "",
        :jkm_percentage => 0.3,
        :jht_employee_percentage => 2,
        :jht_office_percentage => 3.7
      )
      
    jamsostek.should_not be_valid
  end
  
  it "should not allow object creation with zero jkk percentage" do
    code = "JSTK2013"
    jamsostek = Jamsostek.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => "Jamsostek Aturan Tahun 2013",
        :jkk_percentage => 0,
        :jkm_percentage => 0.3,
        :jht_employee_percentage => 2,
        :jht_office_percentage => 3.7
      )
      
    jamsostek.should_not be_valid
  end
  
  it "should not allow object creation with jkk percentage < 0" do
    code = "JSTK2013"
    jamsostek = Jamsostek.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => "Jamsostek Aturan Tahun 2013",
        :jkk_percentage => -5,
        :jkm_percentage => 0.3,
        :jht_employee_percentage => 2,
        :jht_office_percentage => 3.7
      )
      
    jamsostek.should_not be_valid
  end
  
  it "should not allow object creation without jkm percentage" do
    code = "JSTK2013"
    jamsostek = Jamsostek.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => "Jamsostek Aturan Tahun 2013",
        :jkk_percentage => 0.24,
        :jkm_percentage => "",
        :jht_employee_percentage => 2,
        :jht_office_percentage => 3.7
      )
      
    jamsostek.should_not be_valid
  end
  
  it "should not allow object creation with zero jkm percentage" do
    code = "JSTK2013"
    jamsostek = Jamsostek.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => "Jamsostek Aturan Tahun 2013",
        :jkk_percentage => 0.24,
        :jkm_percentage => 0,
        :jht_employee_percentage => 2,
        :jht_office_percentage => 3.7
      )
      
    jamsostek.should_not be_valid
  end
  
  it "should not allow object creation with jkm percentage < 0" do
    code = "JSTK2013"
    jamsostek = Jamsostek.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => "Jamsostek Aturan Tahun 2013",
        :jkk_percentage => 0.24,
        :jkm_percentage => -7,
        :jht_employee_percentage => 2,
        :jht_office_percentage => 3.7
      )
      
    jamsostek.should_not be_valid
  end
  
  it "should not allow object creation without jht employee percentage" do
    code = "JSTK2013"
    jamsostek = Jamsostek.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => "Jamsostek Aturan Tahun 2013",
        :jkk_percentage => 0.24,
        :jkm_percentage => 0.3,
        :jht_employee_percentage => "",
        :jht_office_percentage => 3.7
      )
      
    jamsostek.should_not be_valid
  end
  
  it "should not allow object creation with zero jht employee percentage" do
    code = "JSTK2013"
    jamsostek = Jamsostek.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => "Jamsostek Aturan Tahun 2013",
        :jkk_percentage => 0.24,
        :jkm_percentage => 0.3,
        :jht_employee_percentage => 0,
        :jht_office_percentage => 3.7
      )
      
    jamsostek.should_not be_valid
  end
  
  it "should not allow object creation without jht employee percentage < 0" do
    code = "JSTK2013"
    jamsostek = Jamsostek.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => "Jamsostek Aturan Tahun 2013",
        :jkk_percentage => 0.24,
        :jkm_percentage => 0.3,
        :jht_employee_percentage => -3,
        :jht_office_percentage => 3.7
      )
      
    jamsostek.should_not be_valid
  end
  
  it "should not allow object creation without jht office percentage" do
    code = "JSTK2013"
    jamsostek = Jamsostek.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => "Jamsostek Aturan Tahun 2013",
        :jkk_percentage => 0.24,
        :jkm_percentage => 0.3,
        :jht_employee_percentage => 2,
        :jht_office_percentage => ""
      )
      
    jamsostek.should_not be_valid
  end
  
  it "should not allow object creation with zero jht office percentage" do
    code = "JSTK2013"
    jamsostek = Jamsostek.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => "Jamsostek Aturan Tahun 2013",
        :jkk_percentage => 0.24,
        :jkm_percentage => 0.3,
        :jht_employee_percentage => 2,
        :jht_office_percentage => 0
      )
      
    jamsostek.should_not be_valid
  end
  
  it "should not allow object creation with jht office percentage < 0" do
    code = "JSTK2013"
    jamsostek = Jamsostek.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => "Jamsostek Aturan Tahun 2013",
        :jkk_percentage => 0.24,
        :jkm_percentage => 0.3,
        :jht_employee_percentage => 2,
        :jht_office_percentage => -5
      )
      
    jamsostek.should_not be_valid
  end
  
  it "should not allow object creation with duplicate code" do
    code = "JSTK2013"
    jamsostek =  Jamsostek.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => "Jamsostek Aturan Tahun 2013",
        :jkk_percentage => 0.24,
        :jkm_percentage => 0.3,
        :jht_employee_percentage => 2,
        :jht_office_percentage => 3.7
      )
      
    jamsostek.should be_valid
    
    jamsostek_2 = Jamsostek.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => "Jamsostek Aturan Tahun 2013",
        :jkk_percentage => 0.24,
        :jkm_percentage => 0.3,
        :jht_employee_percentage => 2,
        :jht_office_percentage => 3.7
      )
      
    jamsostek_2.should_not be_valid
  end
  
  context "has been created jamsostek" do
    before(:each) do
      @jamsostek_1_code = "JSTK2013"
      @jamsostek_1_name = "Jamsostek Aturan Tahun 2013"
      @jamsostek = Jamsostek.create_object(
          :office_id => @office.id,
          :code => @jamsostek_1_code,
          :name => @jamsostek_1_name,
          :jkk_percentage => 0.24,
          :jkm_percentage => 0.3,
          :jht_employee_percentage => 2,
          :jht_office_percentage => 3.7
        )
        
      @jamsostek_2_code = "JSTK2020"
      @jamsostek_2_name = "Jamsostek Aturan Tahun 2020"
      @jamsostek_2 = Jamsostek.create_object(
          :office_id => @office.id,
          :code => @jamsostek_2_code,
          :name => @jamsostek_2_name,
          :jkk_percentage => 0.24,
          :jkm_percentage => 0.3,
          :jht_employee_percentage => 2,
          :jht_office_percentage => 3.7
        )
    end
    
    it "should have 2 objects" do
      Jamsostek.count.should == 2 
    end
    
    it "should create valid objects" do
      @jamsostek.should be_valid
      @jamsostek_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_code = "JSTK2017"
      new_name = "Jamsostek Aturan Tahun 2017"
      
      @jamsostek.update_object(
          :office_id => @office.id,
          :code => new_code,
          :name => new_name,
          :jkk_percentage => 0.24,
          :jkm_percentage => 0.3,
          :jht_employee_percentage => 2,
          :jht_office_percentage => 3.7
        )
        
      @jamsostek.should be_valid
      
      @jamsostek.reload 
      
      @jamsostek.name.should == new_name
      @jamsostek.code.should == new_code
    end
    
    it "should not allow duplicate code" do
      @jamsostek_2.update_object(
          :office_id => @office.id,
          :code => @jamsostek_1_code,
          :name => @jamsostek_2_name,
          :jkk_percentage => 0.24,
          :jkm_percentage => 0.3,
          :jht_employee_percentage => 2,
          :jht_office_percentage => 3.7
        )
        
      @jamsostek_2.errors.size.should_not == 0 
      @jamsostek_2.should_not be_valid
    end
    
    it "should be allowed to delete object 2" do
      @jamsostek_2.delete_object
      
      @jamsostek_2.persisted?.should be_falsy  # be_truthy 
      
      Jamsostek.count.should == 1 
    end
  end
end
