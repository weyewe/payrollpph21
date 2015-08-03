require 'rails_helper'

RSpec.describe EmployeeTraining, type: :model do
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
  
  it "should allow object creation with code and name" do
    employee_training = EmployeeTraining.create_object(
        :employee_id => @employee.id,
        :start_date => DateTime.new(2015,05,01),
        :end_date => DateTime.new(2015,05,03),
        :subject => "Training Camp"
      )
      
    employee_training.should be_valid
    
    employee_training.start_date.should == DateTime.new(2015,05,01)
    employee_training.end_date.should == DateTime.new(2015,05,03)
    employee_training.subject.should == "Training Camp"
  end
  
  it "should not allow object creation without employee id" do
    employee_training = EmployeeTraining.create_object( 
        :employee_id => "",
        :start_date => DateTime.new(2015,05,01),
        :end_date => DateTime.new(2015,05,03),
        :subject => "Training Camp"
      )
      
    employee_training.should_not be_valid
  end
  
  it "should not allow object creation with invalid employee id" do
    employee_training = EmployeeTraining.create_object( 
        :employee_id => 0,
        :start_date => DateTime.new(2015,05,01),
        :end_date => DateTime.new(2015,05,03),
        :subject => "Training Camp"
      )
      
    employee_training.should_not be_valid
  end
  
  it "should not allow object creation without start date" do
    employee_training = EmployeeTraining.create_object( 
        :employee_id => @employee.id,
        :start_date => "",
        :end_date => DateTime.new(2015,05,03),
        :subject => "Training Camp"
      )
      
    employee_training.should_not be_valid
  end
  
  it "should not allow object creation without end date" do
    employee_training = EmployeeTraining.create_object( 
        :employee_id => @employee.id,
        :start_date => DateTime.new(2015,05,01),
        :end_date => "",
        :subject => "Training Camp"
      )
      
    employee_training.should_not be_valid
  end
  
  it "should not allow object creation without subject" do
    employee_training = EmployeeTraining.create_object( 
        :employee_id => @employee.id,
        :start_date => DateTime.new(2015,05,01),
        :end_date => DateTime.new(2015,05,03),
        :subject => ""
      )
      
    employee_training.should_not be_valid
  end
  
  context "has been created employee_training" do
    before(:each) do
      @employee_training_1_start_date = DateTime.new(2015,05,01)
      @employee_training_1_end_date = DateTime.new(2015,05,03)
      @employee_training_1_subject = "Training Camp"
      @employee_training = EmployeeTraining.create_object(
          :employee_id => @employee.id,
          :start_date => @employee_training_1_start_date,
          :end_date => @employee_training_1_end_date,
          :subject => @employee_training_1_subject
        )
        
      @employee_training_2_start_date = DateTime.new(2015,05,10)
      @employee_training_2_end_date = DateTime.new(2015,05,15)
      @employee_training_2_subject = "Leadership Training"
      @employee_training_2 = EmployeeTraining.create_object(
          :employee_id => @employee.id,
          :start_date => @employee_training_2_start_date,
          :end_date => @employee_training_2_end_date,
          :subject => @employee_training_2_subject
        )
    end
    
    it "should have 2 objects" do
      EmployeeTraining.count.should == 2 
    end
    
    it "should create valid objects" do
      @employee_training.should be_valid
      @employee_training_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_start_date = DateTime.new(2015,05,10)
      new_end_date = DateTime.new(2015,05,15)
      new_subject = "HR Manajemen"
      
      @employee_training.update_object(
          :employee_id => @employee.id,
          :start_date => new_start_date,
          :end_date => new_end_date,
          :subject => new_subject
        )
        
      @employee_training.should be_valid
      
      @employee_training.reload 
      
      @employee_training.start_date.should == new_start_date
      @employee_training.end_date.should == new_end_date
      @employee_training.subject.should == new_subject
    end
    
    it "should be allowed to delete object 2" do
      @employee_training_2.delete_object
      
      @employee_training_2.persisted?.should be_falsy  # be_truthy 
      
      EmployeeTraining.count.should == 1 
    end
  end
end
