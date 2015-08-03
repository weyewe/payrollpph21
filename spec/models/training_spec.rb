require 'rails_helper'

RSpec.describe Training, type: :model do
  before (:each) do
      @office = Office.create_object(
            :code => "SSD",
            :name => "Solusi Sentral Data"
          )
  end
  
  it "should allow object creation with all required field" do
    subject = "Leadership"
    training = Training.create_object(
        :office_id => @office.id,
        :subject => subject,
        :start_date => DateTime.new(2015,06,10),
        :end_date => DateTime.new(2015,06,13)
      )
      
    training.should be_valid
    
    training.subject.should == subject
  end
  
  it "should not allow object creation without office id" do
    subject = "Leadership"
    training = Training.create_object( 
        :office_id => "",
        :subject => subject,
        :start_date => DateTime.new(2015,06,10),
        :end_date => DateTime.new(2015,06,13)
      )
      
    training.should_not be_valid
  end
  
  it "should not allow object creation with invalid office id" do
    subject = "Leadership"
    training = Training.create_object( 
        :office_id => 0,
        :subject => subject,
        :start_date => DateTime.new(2015,06,10),
        :end_date => DateTime.new(2015,06,13)
      )
      
    training.should_not be_valid
  end
  
  it "should not allow object creation without subject" do
    subject = "Leadership"
    training = Training.create_object( 
        :office_id => @office.id,
        :subject => "",
        :start_date => DateTime.new(2015,06,10),
        :end_date => DateTime.new(2015,06,13)
      )
      
    training.should_not be_valid
  end
  
  it "should not allow object creation without start date" do
    subject = "Leadership"
    training = Training.create_object( 
        :office_id => @office.id,
        :subject => subject,
        :start_date => "",
        :end_date => DateTime.new(2015,06,13)
      )
      
    training.should_not be_valid
  end
  
  it "should not allow object creation without end date" do
    subject = "Leadership"
    training = Training.create_object( 
        :office_id => @office.id,
        :subject => subject,
        :start_date => DateTime.new(2015,06,10),
        :end_date => ""
      )
      
    training.should_not be_valid
  end
  
  context "has been created training" do
    before(:each) do
      @training_1_subject = "Leadership"
      @training_1_start_date = DateTime.new(2015,07,01)
      @training_1_end_date = DateTime.new(2015,07,05)
      @training = Training.create_object(
          :office_id => @office.id,
          :subject => @training_1_subject,
          :start_date => @training_1_start_date,
          :end_date =>@training_1_end_date
        )
        
      @training_2_subject = "Marketing Management"
      @training_2_start_date = DateTime.new(2015,03,01)
      @training_2_end_date = DateTime.new(2015,03,05)
      @training_2 = Training.create_object(
          :office_id => @office.id,
          :subject => @training_2_subject,
          :start_date => @training_2_start_date,
          :end_date => @training_2_end_date
        )
    end
    
    it "should have 2 objects" do
      Training.count.should == 2 
    end
    
    it "should create valid objects" do
      @training.should be_valid
      @training_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_subject = "Payroll"
      
      @training.update_object(
          :office_id => @office.id,
          :subject => new_subject,
          :start_date => DateTime.new(2015,06,10),
          :end_date => DateTime.new(2015,06,13)
        )
        
      @training.should be_valid
      
      @training.reload 
      
      @training.subject.should == new_subject
    end
    
    # it "should not allow duplicate subject" do
    #   @training_2.update_object(
    #       :office_id => @office.id,
    #       :subject => @training_1_subject,
    #       :start_date => DateTime.new(2015,06,10),
    #       :end_date => DateTime.new(2015,06,13)
    #     )
        
    #   @training_2.errors.size.should_not == 0 
    #   @training_2.should_not be_valid
    # end
    
    it "should be allowed to delete object 2" do
      @training_2.delete_object
      
      @training_2.persisted?.should be_falsy  # be_truthy 
      
      Training.count.should == 1 
    end
  end
end
