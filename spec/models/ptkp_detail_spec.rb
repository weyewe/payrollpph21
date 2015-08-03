require 'rails_helper'

RSpec.describe PtkpDetail, type: :model do
  before (:each) do
      @office = Office.create_object(
            :code => "SSD",
            :name => "Solusi Sentral Data"
          )
      
      @ptkp = Ptkp.create_object(
            :office_id => @office.id,
            :code => "PTKP2013",
            :name => "PTKP Aturan Tahun 2013"
          )
  end
  
  it "should allow object creation with code and name" do
    marital_status = MARITAL_STATUS[:single]
    number_of_children = 0
    ptkp_detail = PtkpDetail.create_object(
        :ptkp_id => @ptkp.id,
        :marital_status => marital_status,
        :number_of_children => number_of_children,
        :value => 24300000
      )
      
    ptkp_detail.should be_valid
    
    ptkp_detail.marital_status.should == marital_status
    ptkp_detail.number_of_children.should == number_of_children
    ptkp_detail.value.should == 24300000
  end
  
  it "should not allow object creation without ptkp id" do
    marital_status = MARITAL_STATUS[:single]
    number_of_children = 0
    ptkp_detail = PtkpDetail.create_object(
        :ptkp_id => "",
        :marital_status => marital_status,
        :number_of_children => number_of_children,
        :value => 24300000
      )
      
    ptkp_detail.should_not be_valid
  end
  
  it "should not allow object creation with invalid ptkp id" do
    marital_status = MARITAL_STATUS[:single]
    number_of_children = 0
    ptkp_detail = PtkpDetail.create_object(
        :ptkp_id => 0,
        :marital_status => marital_status,
        :number_of_children => number_of_children,
        :value => 24300000
      )
      
    ptkp_detail.should_not be_valid
  end
  
  it "should not allow object creation without marital status" do
    marital_status = MARITAL_STATUS[:single]
    number_of_children = 0
    ptkp_detail = PtkpDetail.create_object(
        :ptkp_id => @ptkp.id,
        :marital_status => "",
        :number_of_children => number_of_children,
        :value => 24300000
      )
      
    ptkp_detail.should_not be_valid
  end
  
  it "should not allow object creation without number of children" do
    marital_status = MARITAL_STATUS[:single]
    number_of_children = 0
    ptkp_detail = PtkpDetail.create_object(
        :ptkp_id => @ptkp.id,
        :marital_status => marital_status,
        :number_of_children => "",
        :value => 24300000
      )
      
    ptkp_detail.should_not be_valid
  end
  
  it "should not allow object creation without value" do
    marital_status = MARITAL_STATUS[:single]
    number_of_children = 0
    ptkp_detail = PtkpDetail.create_object(
        :ptkp_id => @ptkp.id,
        :marital_status => marital_status,
        :number_of_children => number_of_children,
        :value => ""
      )
      
    ptkp_detail.should_not be_valid
  end
  
  it "should not allow object creation without zero value" do
    marital_status = MARITAL_STATUS[:single]
    number_of_children = 0
    ptkp_detail = PtkpDetail.create_object(
        :ptkp_id => @ptkp.id,
        :marital_status => marital_status,
        :number_of_children => number_of_children,
        :value => 0
      )
      
    ptkp_detail.should_not be_valid
  end
  
  it "should not allow object creation with duplicate marital status and number of children" do
    marital_status = MARITAL_STATUS[:single]
    number_of_children = 0
    ptkp_detail = PtkpDetail.create_object(
        :ptkp_id => @ptkp.id,
        :marital_status => marital_status,
        :number_of_children => number_of_children,
        :value => 24300000
      )
      
    ptkp_detail.should be_valid
    
    ptkp_detail_2 = PtkpDetail.create_object(
        :ptkp_id => @ptkp.id,
        :marital_status => marital_status,
        :number_of_children => number_of_children,
        :value => 24300000
      )
      
    ptkp_detail_2.should_not be_valid
  end
  
  context "has been created ptkp_detail" do
    before(:each) do
      @ptkp_detail_1_marital_status = MARITAL_STATUS[:single]
      @ptkp_detail_1_number_of_children = 0
      @ptkp_detail = PtkpDetail.create_object(
          :ptkp_id => @ptkp.id,
          :marital_status =>  @ptkp_detail_1_marital_status,
          :number_of_children =>  @ptkp_detail_1_number_of_children,
          :value => 24300000
        )
        
      @ptkp_detail_2_marital_status = MARITAL_STATUS[:single]
      @ptkp_detail_2_number_of_children = 1
      @ptkp_detail_2 = PtkpDetail.create_object(
          :ptkp_id => @ptkp.id,
          :marital_status => @ptkp_detail_2_marital_status,
          :number_of_children => @ptkp_detail_2_number_of_children,
          :value => 26325000
        )
    end
    
    it "should have 2 objects" do
      PtkpDetail.count.should == 2 
    end
    
    it "should create valid objects" do
      @ptkp_detail.should be_valid
      @ptkp_detail_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_marital_status = MARITAL_STATUS[:married]
      new_number_of_children = 1
      
      @ptkp_detail.update_object(
          :ptkp_id => @ptkp.id,
          :marital_status => new_marital_status,
          :number_of_children => new_number_of_children,
          :value => 28350000
        )
        
      @ptkp_detail.should be_valid
      
      @ptkp_detail.reload 
      
      @ptkp_detail.marital_status.should == new_marital_status
      @ptkp_detail.number_of_children.should == new_number_of_children
      @ptkp_detail.value.should == 28350000
    end
    
    it "should not allow duplicate code" do
      @ptkp_detail_2.update_object(
          :ptkp_id => @ptkp.id,
          :marital_status => @ptkp_detail_1_marital_status,
          :number_of_children => @ptkp_detail_1_number_of_children
        )
        
      @ptkp_detail_2.errors.size.should_not == 0 
      @ptkp_detail_2.should_not be_valid
    end
    
    it "should be allowed to delete object 2" do
      @ptkp_detail_2.delete_object
      
      @ptkp_detail_2.persisted?.should be_falsy  # be_truthy 
      
      PtkpDetail.count.should == 1 
    end
  end
end
