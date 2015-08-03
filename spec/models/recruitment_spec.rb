require 'rails_helper'

RSpec.describe Recruitment, type: :model do
  before (:each) do
      @office = Office.create_object(
            :code => "SSD",
            :name => "Solusi Sentral Data"
          )
          
      @branch_office = BranchOffice.create_object(
            :office_id => @office.id,
            :code => "SSDSUB",
            :name => "Solusi Sentral Data - Surabaya"
          )
          
      @department = Department.create_object(
            :office_id => @office.id,
            :branch_office_id => @branch_office.id,
            :code => "IT",
            :name => "IT"
          )
     
      @division = Division.create_object(
            :office_id => @office.id,
            :branch_office_id => @branch_office.id,
            :department_id => @department.id,
            :code => "PROG",
            :name => "Programmer"
          )
      
      @title = Title.create_object(
            :office_id => @office.id,
            :code => "JPROG",
            :name => "Junior Programmer"
          )
      
      @level = Level.create_object(
            :office_id => @office.id,
            :code => "STF",
            :name => "Staff"
          )
      
      @status_working = StatusWorking.create_object(
            :office_id => @office.id,
            :code => "PMT",
            :name => "Permanent"
          )
  end
  
  it "should allow object creation with all requiered field" do
    identity_number = "1234567890"
    recruitment = Recruitment.create_object(
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :identity_number => identity_number,
        :name => "Pebrian"
      )
      
    recruitment.should be_valid
    
    recruitment.identity_number.should == identity_number
  end
  
  it "should not allow object creation without office id" do
    identity_number = "1234567890"
    recruitment = Recruitment.create_object( 
        :office_id => "",
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :identity_number => identity_number,
        :name => "Pebrian"
      )
      
    recruitment.should_not be_valid
  end
  
  it "should not allow object creation with invalid office id" do
    identity_number = "1234567890"
    recruitment = Recruitment.create_object( 
        :office_id => 0,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :identity_number => identity_number,
        :name => "Pebrian"
      )
      
    recruitment.should_not be_valid
  end
  
  it "should not allow object creation without branch office id" do
    identity_number = "1234567890"
    recruitment = Recruitment.create_object( 
        :office_id => @office.id,
        :branch_office_id => "",
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :identity_number => identity_number,
        :name => "Pebrian"
      )
      
    recruitment.should_not be_valid
  end
  
  it "should not allow object creation with invalid branch office id" do
    identity_number = "IT"
    recruitment = Recruitment.create_object( 
        :office_id => @office.id,
        :branch_office_id => 0,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :identity_number => identity_number,
        :name => "Pebrian"
      )
      
    recruitment.should_not be_valid
  end
  
  it "should not allow object creation without department id" do
    identity_number = "1234567890"
    recruitment = Recruitment.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => "",
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :identity_number => identity_number,
        :name => "Pebrian"
      )
      
    recruitment.should_not be_valid
  end
  
  it "should not allow object creation with invalid department id" do
    identity_number = "1234567890"
    recruitment = Recruitment.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => 0,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :identity_number => identity_number,
        :name => "Pebrian"
      )
      
    recruitment.should_not be_valid
  end
  
  it "should not allow object creation without division id" do
    identity_number = "1234567890"
    recruitment = Recruitment.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => "",
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :identity_number => identity_number,
        :name => "Pebrian"
      )
      
    recruitment.should_not be_valid
  end
  
  it "should not allow object creation with invalid division id" do
    identity_number = "1234567890"
    recruitment = Recruitment.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => 0,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :identity_number => identity_number,
        :name => "Pebrian"
      )
      
    recruitment.should_not be_valid
  end
  
  it "should not allow object creation without title id" do
    identity_number = "1234567890"
    recruitment = Recruitment.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => "",
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :identity_number => identity_number,
        :name => "Pebrian"
      )
      
    recruitment.should_not be_valid
  end
  
  it "should not allow object creation with invalid title id" do
    identity_number = "1234567890"
    recruitment = Recruitment.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => 0,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :identity_number => identity_number,
        :name => "Pebrian"
      )
      
    recruitment.should_not be_valid
  end
  
  it "should not allow object creation without level id" do
    identity_number = "1234567890"
    recruitment = Recruitment.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => "",
        :status_working_id => @status_working.id,
        :identity_number => identity_number,
        :name => "Pebrian"
      )
      
    recruitment.should_not be_valid
  end
  
  it "should not allow object creation with invalid level id" do
    identity_number = "1234567890"
    recruitment = Recruitment.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => 0,
        :status_working_id => @status_working.id,
        :identity_number => identity_number,
        :name => "Pebrian"
      )
      
    recruitment.should_not be_valid
  end
  
  it "should not allow object creation without working status id" do
    identity_number = "1234567890"
    recruitment = Recruitment.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => "",
        :identity_number => identity_number,
        :name => "Pebrian"
      )
      
    recruitment.should_not be_valid
  end
  
  it "should not allow object creation with invalid working status id" do
    identity_number = "1234567890"
    recruitment = Recruitment.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => 0,
        :identity_number => identity_number,
        :name => "Pebrian"
      )
      
    recruitment.should_not be_valid
  end
  
  it "should not allow object creation without identity_number" do
    identity_number = "1234567890"
    recruitment = Recruitment.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :identity_number => "",
        :name => "Pebrian"
      )
      
    recruitment.should_not be_valid
  end
  
  it "should not allow object creation without full name" do
    identity_number = "1234567890"
    recruitment = Recruitment.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :identity_number => identity_number,
        :name => ""
      )
      
    recruitment.should_not be_valid
  end
  
  it "should not allow object creation with duplicate identity_number" do
    identity_number = "1234567890"
    recruitment =  Recruitment.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :identity_number => identity_number,
        :name => "Pebrian"
      )
      
    recruitment.should be_valid
    
    recruitment_2 = Recruitment.create_object( 
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :identity_number => identity_number,
        :name => "Pebrian"
      )
      
    recruitment_2.should_not be_valid
  end
  
  context "has been created recruitment" do
    before(:each) do
      @recruitment_1_identity_number = "1234567890"
      @recruitment_1_name = "Pebrian"
      @recruitment = Recruitment.create_object(
          :office_id => @office.id,
          :branch_office_id => @branch_office.id,
          :department_id => @department.id,
          :division_id => @division.id,
          :title_id => @title.id,
        :level_id => @level.id,
          :status_working_id => @status_working.id,
          :identity_number => @recruitment_1_identity_number,
          :name => "Pebrian"
        )
        
      @recruitment_2_identity_number = "0987654321"
      @recruitment_2_name = "Bambang"
      @recruitment_2 = Recruitment.create_object(
          :office_id => @office.id,
          :branch_office_id => @branch_office.id,
          :department_id => @department.id,
          :division_id => @division.id,
          :title_id => @title.id,
        :level_id => @level.id,
          :status_working_id => @status_working.id,
          :identity_number => @recruitment_2_identity_number,
          :name => "Pebrian"
        )
    end
    
    it "should have 2 objects" do
      Recruitment.count.should == 2 
    end
    
    it "should create valid objects" do
      @recruitment.should be_valid
      @recruitment_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_identity_number = "6543217890"
      new_name = "Handendari"
      
      @recruitment.update_object(
          :office_id => @office.id,
          :branch_office_id => @branch_office.id,
          :department_id => @department.id,
          :division_id => @division.id,
          :title_id => @title.id,
        :level_id => @level.id,
          :status_working_id => @status_working.id,
          :identity_number => new_identity_number,
          :name => new_name
        )
        
      @recruitment.should be_valid
      
      @recruitment.reload 
      
      @recruitment.identity_number.should == new_identity_number
      @recruitment.name.should == new_name
    end
    
    it "should not allow duplicate identity_number" do
      @recruitment_2.update_object(
          :office_id => @office.id,
          :branch_office_id => @branch_office.id,
          :department_id => @department.id,
          :division_id => @division.id,
          :title_id => @title.id,
        :level_id => @level.id,
          :status_working_id => @status_working.id,
          :identity_number => @recruitment_1_identity_number,
          :name => "Pebrian"
        )
        
      @recruitment_2.errors.size.should_not == 0 
      @recruitment_2.should_not be_valid
    end
    
    it "should be allowed to delete object 2" do
      @recruitment_2.delete_object
      
      @recruitment_2.should be_valid
    end
    
    it "should be allowed to send to bank data" do
      @recruitment_2.send_to_bank_data
      
      @recruitment_2.should be_valid
    end
    
    it "should be allowed to send to bank data" do
      @recruitment_2.send_to_recruitment
      
      @recruitment_2.should be_valid
    end
  end
end
