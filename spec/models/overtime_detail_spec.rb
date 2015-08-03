require 'rails_helper'

RSpec.describe OvertimeDetail, type: :model do
  before (:each) do
      @office = Office.create_object(
            :code => "SSD",
            :name => "Solusi Sentral Data"
          )
      
      @overtime = Overtime.create_object(
            :office_id => @office.id,
            :code => "HK",
            :name => "Overtime di Hari Kerja"
          )
  end
  
  it "should allow object creation with multiplier, from_value and to_value" do
    multiplier = 1.5
    from_value = 0
    to_value = 1
    overtime_detail = OvertimeDetail.create_object(
        :overtime_id => @overtime.id,
        :multiplier => multiplier,
        :from_value => from_value,
        :to_value => to_value
      )
      
    overtime_detail.should be_valid
    
    overtime_detail.multiplier.should == multiplier
    overtime_detail.from_value.should == from_value
    overtime_detail.to_value.should == to_value
  end
  
  it "should not allow object creation without overtime id" do
    multiplier = 1.5
    from_value = 0 
    to_value = 1
    overtime_detail = OvertimeDetail.create_object(
        :overtime_id => "",
        :multiplier => multiplier,
        :from_value => from_value,
        :to_value => to_value
      )
      
    overtime_detail.should_not be_valid
  end
  
  it "should not allow object creation with invalid overtime id" do
    multiplier = 1.5
    from_value = 0 
    to_value = 1
    overtime_detail = OvertimeDetail.create_object(
        :overtime_id => 0,
        :multiplier => multiplier,
        :from_value => from_value,
        :to_value => to_value
      )
      
    overtime_detail.should_not be_valid
  end
  
  it "should not allow object creation without multiplier" do
    multiplier = 1.5
    from_value = 0 
    to_value = 1
    overtime_detail = OvertimeDetail.create_object(
        :overtime_id => @overtime.id,
        :multiplier => "",
        :from_value => from_value,
        :to_value => to_value
      )
      
    overtime_detail.should_not be_valid
  end
  
  it "should not allow object creation without from_value" do
    multiplier = 1.5
    from_value = 0 
    to_value = 1
    overtime_detail = OvertimeDetail.create_object(
        :overtime_id => @overtime.id,
        :multiplier => multiplier,
        :from_value => "",
        :to_value => to_value
      )
      
    overtime_detail.should_not be_valid
  end
  
  it "should not allow object creation without to_value" do
    multiplier = 1.5
    from_value = 0 
    to_value = 1
    overtime_detail = OvertimeDetail.create_object(
        :overtime_id => @overtime.id,
        :multiplier => multiplier,
        :from_value => from_value,
        :to_value => ""
      )
      
    overtime_detail.should_not be_valid
  end
  
  it "should not allow object creation with duplicate multiplier" do
    multiplier = 1.5
    from_value = 0 
    to_value = 1
    overtime_detail = OvertimeDetail.create_object(
        :overtime_id => @overtime.id,
        :multiplier => multiplier,
        :from_value => from_value,
        :to_value => to_value
      )
      
    overtime_detail.should be_valid
    
    overtime_detail_2 = OvertimeDetail.create_object(
        :overtime_id => @overtime.id,
        :multiplier => multiplier,
        :from_value => from_value,
        :to_value => to_value
      )
      
    overtime_detail_2.should_not be_valid
  end
  
  context "has been created overtime_detail" do
    before(:each) do
      @overtime_detail_1_multiplier = 1.5
      @overtime_detail_1_from_value = 0
      @overtime_detail_1_to_value = 1
      @overtime_detail = OvertimeDetail.create_object(
          :overtime_id => @overtime.id,
          :multiplier =>  @overtime_detail_1_multiplier,
          :from_value =>  @overtime_detail_1_from_value,
          :to_value => @overtime_detail_1_to_value
        )
        
      @overtime_detail_2_multiplier = 2
      @overtime_detail_2_from_value = 1
      @overtime_detail_2_to_value = 8
      @overtime_detail_2 = OvertimeDetail.create_object(
          :overtime_id => @overtime.id,
          :multiplier =>  @overtime_detail_2_multiplier,
          :from_value =>  @overtime_detail_2_from_value,
          :to_value => @overtime_detail_2_to_value
        )
    end
    
    it "should have 2 objects" do
      OvertimeDetail.count.should == 2 
    end
    
    it "should create valid objects" do
      @overtime_detail.should be_valid
      @overtime_detail_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_multiplier = 3
      new_from_value = 8
      new_to_value = 24
      
      @overtime_detail.update_object(
          :overtime_id => @overtime.id,
          :multiplier => new_multiplier,
          :from_value => new_from_value,
          :to_value => new_to_value
        )
        
      @overtime_detail.should be_valid
      
      @overtime_detail.reload 
      
      @overtime_detail.multiplier.should == new_multiplier
      @overtime_detail.from_value.should == new_from_value
      @overtime_detail.to_value.should == new_to_value
    end
    
    it "should not allow duplicate code" do
      @overtime_detail_2.update_object(
          :overtime_id => @overtime.id,
          :multiplier => @overtime_detail_1_multiplier,
          :from_value => @overtime_detail_2_from_value,
          :to_value => @overtime_detail_2_to_value
        )
        
      @overtime_detail_2.errors.size.should_not == 0 
      @overtime_detail_2.should_not be_valid
    end
    
    it "should be allowed to delete object 2" do
      @overtime_detail_2.delete_object
      
      @overtime_detail_2.persisted?.should be_falsy  # be_truthy 
      
      OvertimeDetail.count.should == 1 
    end
  end
end
