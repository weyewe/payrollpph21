require 'rails_helper'

RSpec.describe Preference, type: :model do
  before (:each) do
      @office = Office.create_object(
            :code => "SSD",
            :name => "Solusi Sentral Data"
          )
      
      @office_2 = Office.create_object(
            :code => "FE",
            :name => "Freight Express"
          )
      
      @pph21 = Pph21.create_object(
            :office_id => @office.id,
            :code => "PPH212013",
            :name => "PPh21 Aturan Tahun 2013"
          )
  end
  
  it "should allow object creation with all required field" do
    preference = Preference.create_object(
        :office_id => @office.id,
        :ot_divider => 173,
        :biaya_jabatan_percentage => 5,
        :biaya_jabatan_max => 500000,
        :pph_non_npwp_percentage => 20,
        :dpp_percentage => 50,
        :pph21_id => @pph21.id
      )
      
    preference.should be_valid
    
    preference.ot_divider.should == 173
    preference.biaya_jabatan_percentage.should == 5
    preference.biaya_jabatan_max.should == 500000
    preference.pph_non_npwp_percentage.should == 20
    preference.dpp_percentage.should == 50
  end
  
  it "should not allow object creation without office id" do
    preference = Preference.create_object( 
        :office_id => "",
        :ot_divider => 173,
        :biaya_jabatan_percentage => 5,
        :biaya_jabatan_max => 500000,
        :pph_non_npwp_percentage => 20,
        :dpp_percentage => 50,
        :pph21_id => @pph21.id
      )
      
    preference.should_not be_valid
  end
  
  it "should not allow object creation with invalid office id" do
    preference = Preference.create_object( 
        :office_id => 0,
        :ot_divider => 173,
        :biaya_jabatan_percentage => 5,
        :biaya_jabatan_max => 500000,
        :pph_non_npwp_percentage => 20,
        :dpp_percentage => 50,
        :pph21_id => @pph21.id
      )
      
    preference.should_not be_valid
  end
  
  it "should not allow object creation without ot divider" do
    preference = Preference.create_object( 
        :office_id => @office.id,
        :ot_divider => "",
        :biaya_jabatan_percentage => 5,
        :biaya_jabatan_max => 500000,
        :pph_non_npwp_percentage => 20,
        :dpp_percentage => 50,
        :pph21_id => @pph21.id
      )
      
    preference.should_not be_valid
  end
  
  it "should not allow object creation with invalid ot divider" do
    preference = Preference.create_object( 
        :office_id => @office.id,
        :ot_divider => 0,
        :biaya_jabatan_percentage => 5,
        :biaya_jabatan_max => 500000,
        :pph_non_npwp_percentage => 20,
        :dpp_percentage => 50,
        :pph21_id => @pph21.id
      )
      
    preference.should_not be_valid
  end
  
  it "should not allow object creation without biaya jabatan percentage" do
    preference = Preference.create_object( 
        :office_id => @office.id,
        :ot_divider => 173,
        :biaya_jabatan_percentage => "",
        :biaya_jabatan_max => 500000,
        :pph_non_npwp_percentage => 20,
        :dpp_percentage => 50,
        :pph21_id => @pph21.id
      )
      
    preference.should_not be_valid
  end
  
  it "should not allow object creation without biaya jabatan max" do
    preference = Preference.create_object( 
        :office_id => @office.id,
        :ot_divider => 173,
        :biaya_jabatan_percentage => 5,
        :biaya_jabatan_max => "",
        :pph_non_npwp_percentage => 20,
        :dpp_percentage => 50,
        :pph21_id => @pph21.id
      )
      
    preference.should_not be_valid
  end
  
  it "should not allow object creation without biaya pph non npwp percentage" do
    preference = Preference.create_object( 
        :office_id => @office.id,
        :ot_divider => 173,
        :biaya_jabatan_percentage => 5,
        :biaya_jabatan_max => 500000,
        :pph_non_npwp_percentage => "",
        :dpp_percentage => 50,
        :pph21_id => @pph21.id
      )
      
    preference.should_not be_valid
  end
  
  it "should not allow object creation without dpp percentage" do
    preference = Preference.create_object( 
        :office_id => @office.id,
        :ot_divider => 173,
        :biaya_jabatan_percentage => 5,
        :biaya_jabatan_max => 500000,
        :pph_non_npwp_percentage => 20,
        :dpp_percentage => "",
        :pph21_id => @pph21.id
      )
      
    preference.should_not be_valid
  end
  
  it "should not allow object creation without pph non employee id" do
    preference = Preference.create_object( 
        :office_id => @office.id,
        :ot_divider => 173,
        :biaya_jabatan_percentage => 5,
        :biaya_jabatan_max => 500000,
        :pph_non_npwp_percentage => 20,
        :dpp_percentage => 50,
        :pph21_id => ""
      )
      
    preference.should_not be_valid
  end
  
  it "should not allow object creation with invalid pph non employee id" do
    preference = Preference.create_object( 
        :office_id => @office.id,
        :ot_divider => 173,
        :biaya_jabatan_percentage => 5,
        :biaya_jabatan_max => 500000,
        :pph_non_npwp_percentage => 20,
        :dpp_percentage => 50,
        :pph21_id => 0
      )
      
    preference.should_not be_valid
  end
  
  it "should not allow object creation with duplicate code" do
    preference =  Preference.create_object( 
        :office_id => @office.id,
        :ot_divider => 173,
        :biaya_jabatan_percentage => 5,
        :biaya_jabatan_max => 500000,
        :pph_non_npwp_percentage => 20,
        :dpp_percentage => 50,
        :pph21_id => @pph21.id
      )
      
    preference.should be_valid
    
    preference_2 = Preference.create_object( 
        :office_id => @office.id,
        :ot_divider => 173,
        :biaya_jabatan_percentage => 5,
        :biaya_jabatan_max => 500000,
        :pph_non_npwp_percentage => 20,
        :dpp_percentage => 50,
        :pph21_id => @pph21.id
      )
      
    preference_2.should_not be_valid
  end
  
  context "has been created preference" do
    before(:each) do
      @preference = Preference.create_object(
          :office_id => @office.id,
          :ot_divider => 173,
          :biaya_jabatan_percentage => 5,
          :biaya_jabatan_max => 500000,
          :pph_non_npwp_percentage => 20,
          :dpp_percentage => 50,
          :pph21_id => @pph21.id
        )
        
      @preference_2 = Preference.create_object(
          :office_id => @office_2.id,
          :ot_divider => 173,
          :biaya_jabatan_percentage => 5,
          :biaya_jabatan_max => 500000,
          :pph_non_npwp_percentage => 20,
          :dpp_percentage => 50,
          :pph21_id => @pph21.id
        )
    end
    
    it "should have 2 objects" do
      Preference.count.should == 2 
    end
    
    it "should create valid objects" do
      @preference.should be_valid
      @preference_2.should be_valid
    end
    
    it "should be allowed to update" do
      @preference.update_object(
          :office_id => @office.id,
          :ot_divider => 175,
          :biaya_jabatan_percentage => 5,
          :biaya_jabatan_max => 500000,
          :pph_non_npwp_percentage => 20,
          :dpp_percentage => 50,
          :pph21_id => @pph21.id
        )
        
      @preference.should be_valid
      
      @preference.reload 
      
      @preference.ot_divider.should == 175
      @preference.biaya_jabatan_percentage.should == 5
      @preference.biaya_jabatan_max.should == 500000
      @preference.pph_non_npwp_percentage.should == 20
      @preference.dpp_percentage.should == 50
    end
    
    it "should not allow duplicate code" do
      @preference_2.update_object(
          :office_id => @office.id,
          :ot_divider => 173,
          :biaya_jabatan_percentage => 5,
          :biaya_jabatan_max => 500000,
          :pph_non_npwp_percentage => 20,
          :dpp_percentage => 50,
          :pph21_id => @pph21.id
        )
        
      @preference_2.errors.size.should_not == 0 
      @preference_2.should_not be_valid
    end
    
    it "should be allowed to delete object 2" do
      @preference_2.delete_object
      
      @preference_2.persisted?.should be_falsy  # be_truthy 
      
      Preference.count.should == 1 
    end
  end
end
