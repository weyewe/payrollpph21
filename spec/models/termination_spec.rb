require 'rails_helper'

RSpec.describe Termination, type: :model do
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
            :code => "007",
            :name => "Programmer"
          )
      
      @title = Title.create_object(
            :office_id => @office.id,
            :code => "J007",
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
      
      @bank = Bank.create_object(
            :office_id => @office.id,
            :code => "BCA",
            :name => "Bank Central Asia"
          )
      
      @employee = Employee.create_object(
            :office_id => @office.id,
            :branch_office_id => @branch_office.id,
            :department_id => @department.id,
            :division_id => @division.id,
            :title_id => @title.id,
            :level_id => @level.id,
            :status_working_id => @status_working.id,
            :code => "007",
            :full_name => "Pebrian",
            :nick_name => "Pebri",
            :enroll_id => 12,
            :bank_id => @bank.id
          )
  end
  
  it "should allow object creation with all required field" do
    termination = Termination.create_object(
        :employee_id => @employee.id,
        :date => DateTime.new(2015,2,8),
        :description => "PHK"
      )
      
    termination.should be_valid
  end
  
  it "should not allow object creation without employee id" do
    termination = Termination.create_object( 
        :employee_id => "",
        :date => DateTime.new(2015,2,8),
        :description => "PHK"
      )
      
    termination.should_not be_valid
  end
  
  it "should not allow object creation with invalid employee id" do
    termination = Termination.create_object( 
        :employee_id => 0,
        :date => DateTime.new(2015,2,8),
        :description => "PHK"
      )
      
    termination.should_not be_valid
  end
  
  it "should not allow object creation without date" do
    termination = Termination.create_object( 
        :employee_id => @employee.id,
        :date => "",
        :description => "PHK"
      )
      
    termination.should_not be_valid
  end
  
  it "should not allow object creation without description" do
    termination = Termination.create_object( 
        :employee_id => @employee.id,
        :date => DateTime.new(2015,2,8),
        :description => ""
      )
      
    termination.should_not be_valid
  end
  
  context "has been created termination" do
    before(:each) do
      @termination = Termination.create_object(
          :employee_id => @employee.id,
          :date => DateTime.new(2015,2,8),
          :description => "PHK"
        )
        
      @termination_2 = Termination.create_object(
          :employee_id => @employee.id,
          :date => DateTime.new(2015,6,22),
          :description => "Pensiun"
        )
    end
    
    it "should have 2 objects" do
      Termination.count.should == 2 
    end
    
    it "should create valid objects" do
      @termination.should be_valid
      @termination_2.should be_valid
    end
    
    it "should be allowed to update" do
      @termination.update_object(
          :employee_id => @employee.id,
          :date => DateTime.new(2015,3,8),
          :description => "Resign"
        )
        
      @termination.should be_valid
      
      @termination.reload 
    end
    
    it "should be allowed to delete object 2" do
      @termination_2.delete_object
      
      @termination_2.should be_valid
    end
    
    it "should not be allowed to unapprove object 2" do
      @termination_2.unapprove_object
      
      @termination_2.should be_valid
    end
    
    context "has been deleted private termination" do
        before(:each) do
            @termination_2.delete_object
        end
        
        it "should delete valid object" do
            @termination_2.should be_valid
        end
        
        it "should be allowed to create object 3" do
          @termination_3 = Termination.create_object(
              :employee_id => @employee.id,
              :date => DateTime.new(2015,6,22),
              :description => "PHK"
            )
          
          @termination_3.should be_valid
        end
    end
    
    context "has been approved private termination" do
        before(:each) do
            @termination_2.approve_object
        end
        
        it "should update valid object" do
            @termination_2.should be_valid
        end
        
        it "should be allowed to delete object 2" do
          @termination_2.delete_object
          
          @termination_2.should be_valid
        end
        
        it "should be allowed to unapprove object 2" do
          @termination_2.unapprove_object
          
          @termination_2.should be_valid
        end 
    end
    
  end
end
