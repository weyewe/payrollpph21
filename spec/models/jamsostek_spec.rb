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
        :jht_office_percentage => 3.7,
        :jp_employee_percentage => 1,
        :jp_office_percentage => 2,
        :jp_maximum_salary => 7000000
      )
      
    jamsostek.should be_valid
    
    jamsostek.code.should == code
    jamsostek.jkk_percentage.should == 0.24
    jamsostek.jkm_percentage.should == 0.3
    jamsostek.jht_employee_percentage.should == 2
    jamsostek.jht_office_percentage.should == 3.7
    jamsostek.jp_employee_percentage.should == 1
    jamsostek.jp_office_percentage.should == 2
    jamsostek.jp_maximum_salary.should == 7000000
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
        :jht_office_percentage => 3.7,
        :jp_employee_percentage => 1,
        :jp_office_percentage => 2,
        :jp_maximum_salary => 7000000
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
        :jht_office_percentage => 3.7,
        :jp_employee_percentage => 1,
        :jp_office_percentage => 2,
        :jp_maximum_salary => 7000000
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
        :jht_office_percentage => 3.7,
        :jp_employee_percentage => 1,
        :jp_office_percentage => 2,
        :jp_maximum_salary => 7000000
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
        :jht_office_percentage => 3.7,
        :jp_employee_percentage => 1,
        :jp_office_percentage => 2,
        :jp_maximum_salary => 7000000
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
        :jht_office_percentage => 3.7,
        :jp_employee_percentage => 1,
        :jp_office_percentage => 2,
        :jp_maximum_salary => 7000000
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
        :jht_office_percentage => 3.7,
        :jp_employee_percentage => 1,
        :jp_office_percentage => 2,
        :jp_maximum_salary => 7000000
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
        :jht_office_percentage => 3.7,
        :jp_employee_percentage => 1,
        :jp_office_percentage => 2,
        :jp_maximum_salary => 7000000
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
        :jht_office_percentage => 3.7,
        :jp_employee_percentage => 1,
        :jp_office_percentage => 2,
        :jp_maximum_salary => 7000000
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
        :jht_office_percentage => 3.7,
        :jp_employee_percentage => 1,
        :jp_office_percentage => 2,
        :jp_maximum_salary => 7000000
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
        :jht_office_percentage => 3.7,
        :jp_employee_percentage => 1,
        :jp_office_percentage => 2,
        :jp_maximum_salary => 7000000
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
        :jht_office_percentage => 3.7,
        :jp_employee_percentage => 1,
        :jp_office_percentage => 2,
        :jp_maximum_salary => 7000000
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
        :jht_office_percentage => 3.7,
        :jp_employee_percentage => 1,
        :jp_office_percentage => 2,
        :jp_maximum_salary => 7000000
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
        :jht_office_percentage => 3.7,
        :jp_employee_percentage => 1,
        :jp_office_percentage => 2,
        :jp_maximum_salary => 7000000
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
        :jht_office_percentage => "",
        :jp_employee_percentage => 1,
        :jp_office_percentage => 2,
        :jp_maximum_salary => 7000000
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
        :jht_office_percentage => 0,
        :jp_employee_percentage => 1,
        :jp_office_percentage => 2,
        :jp_maximum_salary => 7000000
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
        :jht_office_percentage => -5,
        :jp_employee_percentage => 1,
        :jp_office_percentage => 2,
        :jp_maximum_salary => 7000000
      )
      
    jamsostek.should_not be_valid
  end
  
  it "should not allow object creation without jp employee percentage" do
    code = "JSTK2013"
    jamsostek = Jamsostek.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => "Jamsostek Aturan Tahun 2013",
        :jkk_percentage => 0.24,
        :jkm_percentage => 0.3,
        :jht_employee_percentage => 2,
        :jht_office_percentage => 3.7,
        :jp_employee_percentage => "",
        :jp_office_percentage => 2,
        :jp_maximum_salary => 7000000
      )
      
    jamsostek.should_not be_valid
  end
  
  it "should not allow object creation with zero jp employee percentage" do
    code = "JSTK2013"
    jamsostek = Jamsostek.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => "Jamsostek Aturan Tahun 2013",
        :jkk_percentage => 0.24,
        :jkm_percentage => 0.3,
        :jht_employee_percentage => 2,
        :jht_office_percentage => 3.7,
        :jp_employee_percentage => 0,
        :jp_office_percentage => 2,
        :jp_maximum_salary => 7000000
      )
      
    jamsostek.should_not be_valid
  end
  
  it "should not allow object creation without jp employee percentage < 0" do
    code = "JSTK2013"
    jamsostek = Jamsostek.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => "Jamsostek Aturan Tahun 2013",
        :jkk_percentage => 0.24,
        :jkm_percentage => 0.3,
        :jht_employee_percentage => 2,
        :jht_office_percentage => 3.7,
        :jp_employee_percentage => -3,
        :jp_office_percentage => 2,
        :jp_maximum_salary => 7000000
      )
      
    jamsostek.should_not be_valid
  end
  
  it "should not allow object creation without jp office percentage" do
    code = "JSTK2013"
    jamsostek = Jamsostek.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => "Jamsostek Aturan Tahun 2013",
        :jkk_percentage => 0.24,
        :jkm_percentage => 0.3,
        :jht_employee_percentage => 2,
        :jht_office_percentage => 3.7,
        :jp_employee_percentage => 1,
        :jp_office_percentage => "",
        :jp_maximum_salary => 7000000
      )
      
    jamsostek.should_not be_valid
  end
  
  it "should not allow object creation with zero jp office percentage" do
    code = "JSTK2013"
    jamsostek = Jamsostek.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => "Jamsostek Aturan Tahun 2013",
        :jkk_percentage => 0.24,
        :jkm_percentage => 0.3,
        :jht_employee_percentage => 2,
        :jht_office_percentage => 3.7,
        :jp_employee_percentage => 1,
        :jp_office_percentage => 0,
        :jp_maximum_salary => 7000000
      )
      
    jamsostek.should_not be_valid
  end
  
  it "should not allow object creation with jp office percentage < 0" do
    code = "JSTK2013"
    jamsostek = Jamsostek.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => "Jamsostek Aturan Tahun 2013",
        :jkk_percentage => 0.24,
        :jkm_percentage => 0.3,
        :jht_employee_percentage => 2,
        :jht_office_percentage => 3.7,
        :jp_employee_percentage => 1,
        :jp_office_percentage => -2,
        :jp_maximum_salary => 7000000
      )
      
    jamsostek.should_not be_valid
  end
  
  it "should not allow object creation without jp maximum salary" do
    code = "JSTK2013"
    jamsostek = Jamsostek.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => "Jamsostek Aturan Tahun 2013",
        :jkk_percentage => 0.24,
        :jkm_percentage => 0.3,
        :jht_employee_percentage => 2,
        :jht_office_percentage => 3.7,
        :jp_employee_percentage => 1,
        :jp_office_percentage => 2,
        :jp_maximum_salary => ""
      )
      
    jamsostek.should_not be_valid
  end
  
  it "should not allow object creation with zero jp maximum salary" do
    code = "JSTK2013"
    jamsostek = Jamsostek.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => "Jamsostek Aturan Tahun 2013",
        :jkk_percentage => 0.24,
        :jkm_percentage => 0.3,
        :jht_employee_percentage => 2,
        :jht_office_percentage => 3.7,
        :jp_employee_percentage => 1,
        :jp_office_percentage => 2,
        :jp_maximum_salary => 0
      )
      
    jamsostek.should_not be_valid
  end
  
  it "should not allow object creation with jp maximum salaary < 0" do
    code = "JSTK2013"
    jamsostek = Jamsostek.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => "Jamsostek Aturan Tahun 2013",
        :jkk_percentage => 0.24,
        :jkm_percentage => 0.3,
        :jht_employee_percentage => 2,
        :jht_office_percentage => 3.7,
        :jp_employee_percentage => 1,
        :jp_office_percentage => 2,
        :jp_maximum_salary => -300000
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
        :jht_office_percentage => 3.7,
        :jp_employee_percentage => 1,
        :jp_office_percentage => 2,
        :jp_maximum_salary => 7000000
      )
      
    jamsostek.should be_valid
    
    jamsostek_2 = Jamsostek.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => "Jamsostek Aturan Tahun 2013",
        :jkk_percentage => 0.24,
        :jkm_percentage => 0.3,
        :jht_employee_percentage => 2,
        :jht_office_percentage => 3.7,
        :jp_employee_percentage => 1,
        :jp_office_percentage => 2,
        :jp_maximum_salary => 7000000
      )
      
    jamsostek_2.should_not be_valid
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
        :jht_office_percentage => 3.7,
        :jp_employee_percentage => 1,
        :jp_office_percentage => 2,
        :jp_maximum_salary => 7000000
      )
      
    jamsostek.should be_valid
    
    jamsostek_2 = Jamsostek.create_object( 
        :office_id => @office.id,
        :code => code,
        :name => "Jamsostek Aturan Tahun 2013",
        :jkk_percentage => 0.24,
        :jkm_percentage => 0.3,
        :jht_employee_percentage => 2,
        :jht_office_percentage => 3.7,
        :jp_employee_percentage => 1,
        :jp_office_percentage => 2,
        :jp_maximum_salary => 7000000
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
          :jht_office_percentage => 3.7,
          :jp_employee_percentage => 1,
          :jp_office_percentage => 2,
          :jp_maximum_salary => 7000000
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
          :jht_office_percentage => 3.7,
          :jp_employee_percentage => 1,
          :jp_office_percentage => 2,
          :jp_maximum_salary => 7000000
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
          :jht_office_percentage => 3.7,
          :jp_employee_percentage => 1,
          :jp_office_percentage => 2,
          :jp_maximum_salary => 7000000
        )
        
      @jamsostek.should be_valid
      
      @jamsostek.reload 
      
      @jamsostek.name.should == new_name
      @jamsostek.code.should == new_code
      @jamsostek.jkk_percentage.should == 0.24
      @jamsostek.jkm_percentage.should == 0.3
      @jamsostek.jht_employee_percentage.should == 2
      @jamsostek.jht_office_percentage.should == 3.7
      @jamsostek.jp_employee_percentage.should == 1
      @jamsostek.jp_office_percentage.should == 2
      @jamsostek.jp_maximum_salary.should == 7000000
    end
    
    it "should not allow duplicate code" do
      @jamsostek_2.update_object(
          :office_id => @office.id,
          :code => @jamsostek_1_code,
          :name => @jamsostek_2_name,
          :jkk_percentage => 0.24,
          :jkm_percentage => 0.3,
          :jht_employee_percentage => 2,
          :jht_office_percentage => 3.7,
          :jp_employee_percentage => 1,
          :jp_office_percentage => 2,
          :jp_maximum_salary => 7000000
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
