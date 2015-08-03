require 'rails_helper'

RSpec.describe Pph21Detail, type: :model do
  before (:each) do
      @office = Office.create_object(
            :code => "SSD",
            :name => "Solusi Sentral Data"
          )
      
      @pph21 = Pph21.create_object(
            :office_id => @office.id,
            :code => "PPh212013",
            :name => "PPh21 Aturan Tahun 2013"
          )
  end
  
  it "should allow object creation with percentage, from_value and to_value" do
    percentage = 0
    from_value = 0 
    to_value = 50000000
    pph21_detail = Pph21Detail.create_object(
        :pph21_id => @pph21.id,
        :percentage => percentage,
        :from_value => from_value,
        :to_value => to_value
      )
      
    pph21_detail.should be_valid
    
    pph21_detail.percentage.should == percentage
    pph21_detail.from_value.should == from_value
    pph21_detail.to_value.should == to_value
  end
  
  it "should not allow object creation without pph21 id" do
    percentage = 0
    from_value = 0 
    to_value = 50000000
    pph21_detail = Pph21Detail.create_object(
        :pph21_id => "",
        :percentage => percentage,
        :from_value => from_value,
        :to_value => to_value
      )
      
    pph21_detail.should_not be_valid
  end
  
  it "should not allow object creation with invalid pph21 id" do
    percentage = 0
    from_value = 0 
    to_value = 50000000
    pph21_detail = Pph21Detail.create_object(
        :pph21_id => 0,
        :percentage => percentage,
        :from_value => from_value,
        :to_value => to_value
      )
      
    pph21_detail.should_not be_valid
  end
  
  it "should not allow object creation without percentage" do
    percentage = 0
    from_value = 0 
    to_value = 50000000
    pph21_detail = Pph21Detail.create_object(
        :pph21_id => @pph21.id,
        :percentage => "",
        :from_value => from_value,
        :to_value => to_value
      )
      
    pph21_detail.should_not be_valid
  end
  
  it "should not allow object creation without from_value" do
    percentage = 0
    from_value = 0 
    to_value = 50000000
    pph21_detail = Pph21Detail.create_object(
        :pph21_id => @pph21.id,
        :percentage => percentage,
        :from_value => "",
        :to_value => to_value
      )
      
    pph21_detail.should_not be_valid
  end
  
  it "should not allow object creation without to_value" do
    percentage = 0
    from_value = 0 
    to_value = 50000000
    pph21_detail = Pph21Detail.create_object(
        :pph21_id => @pph21.id,
        :percentage => percentage,
        :from_value => from_value,
        :to_value => ""
      )
      
    pph21_detail.should_not be_valid
  end
  
  it "should not allow object creation with duplicate percentage" do
    percentage = 0
    from_value = 0 
    to_value = 50000000
    pph21_detail = Pph21Detail.create_object(
        :pph21_id => @pph21.id,
        :percentage => percentage,
        :from_value => from_value,
        :to_value => to_value
      )
      
    pph21_detail.should be_valid
    
    pph21_detail_2 = Pph21Detail.create_object(
        :pph21_id => @pph21.id,
        :percentage => percentage,
        :from_value => from_value,
        :to_value => to_value
      )
      
    pph21_detail_2.should_not be_valid
  end
  
  context "has been created pph21_detail" do
    before(:each) do
      @pph21_detail_1_percentage = 0
      @pph21_detail_1_from_value = 0
      @pph21_detail_1_to_value = 50000000
      @pph21_detail = Pph21Detail.create_object(
          :pph21_id => @pph21.id,
          :percentage =>  @pph21_detail_1_percentage,
          :from_value =>  @pph21_detail_1_from_value,
          :to_value => @pph21_detail_1_to_value
        )
        
      @pph21_detail_2_percentage = 5
      @pph21_detail_2_from_value = 50000000
      @pph21_detail_2_to_value = 250000000
      @pph21_detail_2 = Pph21Detail.create_object(
          :pph21_id => @pph21.id,
          :percentage =>  @pph21_detail_2_percentage,
          :from_value =>  @pph21_detail_2_from_value,
          :to_value => @pph21_detail_2_to_value
        )
    end
    
    it "should have 2 objects" do
      Pph21Detail.count.should == 2 
    end
    
    it "should create valid objects" do
      @pph21_detail.should be_valid
      @pph21_detail_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_percentage = 15
      new_from_value = 250000000
      new_to_value = 500000000
      
      @pph21_detail.update_object(
          :pph21_id => @pph21.id,
          :percentage => new_percentage,
          :from_value => new_from_value,
          :to_value => new_to_value
        )
        
      @pph21_detail.should be_valid
      
      @pph21_detail.reload 
      
      @pph21_detail.percentage.should == new_percentage
      @pph21_detail.from_value.should == new_from_value
      @pph21_detail.to_value.should == new_to_value
    end
    
    it "should not allow duplicate code" do
      @pph21_detail_2.update_object(
          :pph21_id => @pph21.id,
          :percentage => @pph21_detail_1_percentage,
          :from_value => @pph21_detail_2_from_value,
          :to_value => @pph21_detail_2_to_value
        )
        
      @pph21_detail_2.errors.size.should_not == 0 
      @pph21_detail_2.should_not be_valid
    end
    
    it "should be allowed to delete object 2" do
      @pph21_detail_2.delete_object
      
      @pph21_detail_2.persisted?.should be_falsy  # be_truthy 
      
      Pph21Detail.count.should == 1 
    end
  end
end
