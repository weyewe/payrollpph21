require 'rails_helper'

RSpec.describe BpjsPercentage, type: :model do
  before (:each) do
      @office = Office.create_object(
            :code => "SSD",
            :name => "Solusi Sentral Data"
          )
          
      @office_2 = Office.create_object(
            :code => "FE",
            :name => "Freight Express"
          )
  end
  
  it "should allow object creation with all required field" do
    bpjs_percentage = BpjsPercentage.create_object(
        :office_id => @office.id,
        :employee_percentage => 2,
        :office_percentage => 4,
        :max_of_children => 3
      )
      
    bpjs_percentage.should be_valid
    
    bpjs_percentage.employee_percentage.should == 2
    bpjs_percentage.office_percentage.should == 4
    bpjs_percentage.max_of_children.should == 3
  end
  
  it "should not allow object creation without office id" do
    bpjs_percentage = BpjsPercentage.create_object(
        :office_id => "",
        :employee_percentage => 2,
        :office_percentage => 4,
        :max_of_children => 3
      )
      
    bpjs_percentage.should_not be_valid
  end
  
  it "should not allow object creation with invalid office id" do
    bpjs_percentage = BpjsPercentage.create_object(
        :office_id => 0,
        :employee_percentage => 2,
        :office_percentage => 4,
        :max_of_children => 3
      )
      
    bpjs_percentage.should_not be_valid
  end
  
  it "should not allow object creation without employee_percentage" do
    bpjs_percentage = BpjsPercentage.create_object(
        :office_id => @office.id,
        :employee_percentage => "",
        :office_percentage => 4,
        :max_of_children => 3
      )
      
    bpjs_percentage.should_not be_valid
  end
  
  it "should not allow object creation without office percentage" do
    bpjs_percentage = BpjsPercentage.create_object( 
        :office_id => @office.id,
        :employee_percentage => 2,
        :office_percentage => "",
        :max_of_children => 3
      )
      
    bpjs_percentage.should_not be_valid
  end
  
  it "should not allow object creation without max of children" do
    bpjs_percentage = BpjsPercentage.create_object( 
        :office_id => @office.id,
        :employee_percentage => 2,
        :office_percentage => 4,
        :max_of_children => ""
      )
      
    bpjs_percentage.should_not be_valid
  end
  
  it "should not allow object creation with office id" do
    bpjs_percentage =  BpjsPercentage.create_object( 
        :office_id => @office.id,
        :employee_percentage => 2,
        :office_percentage => 4,
        :max_of_children => 3
      )
      
    bpjs_percentage.should be_valid
    
    bpjs_percentage_2 = BpjsPercentage.create_object( 
        :office_id => @office.id,
        :employee_percentage => 2,
        :office_percentage => 4,
        :max_of_children => 3
      )
      
    bpjs_percentage_2.should_not be_valid
  end
  
  context "has been created bpjs_percentage" do
    before(:each) do
      @bpjs_percentage = BpjsPercentage.create_object(
          :office_id => @office.id,
          :employee_percentage => 2,
          :office_percentage => 4,
          :max_of_children => 3
        )
        
      @bpjs_percentage_2 = BpjsPercentage.create_object(
          :office_id => @office_2.id,
          :employee_percentage => 2,
          :office_percentage => 4,
          :max_of_children => 3
        )
    end
    
    it "should have 2 objects" do
      BpjsPercentage.count.should == 2 
    end
    
    it "should create valid objects" do
      @bpjs_percentage.should be_valid
      @bpjs_percentage_2.should be_valid
    end
    
    it "should be allowed to update" do
      @bpjs_percentage.update_object(
          :office_id => @office.id,
          :employee_percentage => 1,
          :office_percentage => 3,
          :max_of_children => 3
        )
        
      @bpjs_percentage.should be_valid
      
      @bpjs_percentage.reload
      
      @bpjs_percentage.employee_percentage.should == 1
      @bpjs_percentage.office_percentage.should == 3
      @bpjs_percentage.max_of_children.should == 3
    end
    
    it "should not allow duplicate office id" do
      @bpjs_percentage_2.update_object(
          :office_id => @office.id,
          :employee_percentage => 2,
          :office_percentage => 4,
          :max_of_children => 3
        )
        
      @bpjs_percentage_2.errors.size.should_not == 0 
      @bpjs_percentage_2.should_not be_valid
    end
    
    it "should be allowed to delete object 2" do
      @bpjs_percentage_2.delete_object
      
      @bpjs_percentage_2.persisted?.should be_falsy  # be_truthy 
      
      BpjsPercentage.count.should == 1
    end
  end
end
