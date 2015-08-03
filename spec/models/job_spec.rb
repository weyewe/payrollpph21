require 'rails_helper'

RSpec.describe Job, type: :model do
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
      
      @shift = Shift.create_object(
            :office_id => @office.id,
            :code => "SFT",
            :name => "SHIFT",
            :start_time => 480,
            :duration => 8
          )
      
      @shift_allocation = ShiftAllocation.create_object(
          :shift_id => @shift.id ,
          :employee_id => @employee.id
          )
      
      @shift_detail = ShiftDetail.create_object(
            :shift_id => @shift.id,
            :day_code => DAY_CODE[:sunday],
            :start_time => 480,
            :duration => 8
         )
      
      @shift_detail_2 = ShiftDetail.create_object(
            :shift_id => @shift.id,
            :day_code => DAY_CODE[:monday],
            :start_time => 480,
            :duration => 8
         )
      
      @shift_detail_3 = ShiftDetail.create_object(
            :shift_id => @shift.id,
            :day_code => DAY_CODE[:tuesday],
            :start_time => 480,
            :duration => 8
         )
      
      @shift_detail_4 = ShiftDetail.create_object(
            :shift_id => @shift.id,
            :day_code => DAY_CODE[:wednesday],
            :start_time => 480,
            :duration => 8
         )
      
      @shift_detail_5 = ShiftDetail.create_object(
            :shift_id => @shift.id,
            :day_code => DAY_CODE[:thursday],
            :start_time => 480,
            :duration => 8
         )
      
      @shift_detail_6 = ShiftDetail.create_object(
            :shift_id => @shift.id,
            :day_code => DAY_CODE[:friday],
            :start_time => 480,
            :duration => 8
         )
      
      @shift_detail_7 = ShiftDetail.create_object(
            :shift_id => @shift.id,
            :day_code => DAY_CODE[:saturday],
            :start_time => 480,
            :duration => 6
         )
  end
  
  it "should allow object creation with all required field" do
    job = Job.create_object(
        :employee_id => @employee.id,
        :start_date => DateTime.new(2015,2,8),
        :end_date => DateTime.new(2015,2,18),
        :destination => "Jakarta"
      )
      
    job.should be_valid
  end
  
  it "should not allow object creation without employee id" do
    job = Job.create_object( 
        :employee_id => "",
        :start_date => DateTime.new(2015,2,8),
        :end_date => DateTime.new(2015,2,18),
        :destination => "Jakarta"
      )
      
    job.should_not be_valid
  end
  
  it "should not allow object creation with invalid employee id" do
    job = Job.create_object( 
        :employee_id => 0,
        :start_date => DateTime.new(2015,2,8),
        :end_date => DateTime.new(2015,2,18),
        :destination => "Jakarta"
      )
      
    job.should_not be_valid
  end
  
  it "should not allow object creation without start date" do
    job = Job.create_object( 
        :employee_id => @employee.id,
        :start_date => "",
        :end_date => DateTime.new(2015,2,18),
        :destination => "Jakarta"
      )
      
    job.should_not be_valid
  end
  
  it "should not allow object creation without end date" do
    job = Job.create_object( 
        :employee_id => @employee.id,
        :start_date => DateTime.new(2015,2,8),
        :end_date => "",
        :destination => "Jakarta"
      )
      
    job.should_not be_valid
  end
  
  it "should not allow object creation without destination" do
    job = Job.create_object( 
        :employee_id => @employee.id,
        :start_date => DateTime.new(2015,2,8),
        :end_date => DateTime.new(2015,2,18),
        :destination => ""
      )
      
    job.should_not be_valid
  end
  
  context "has been created job" do
    before(:each) do
      @job = Job.create_object(
          :employee_id => @employee.id,
          :start_date => DateTime.new(2015,2,8),
          :end_date => DateTime.new(2015,2,18),
          :destination => "Jakarta"
        )
        
      @job_2 = Job.create_object(
          :employee_id => @employee.id,
          :start_date => DateTime.new(2015,3,8),
          :end_date => DateTime.new(2015,3,18),
          :destination => "Semarang"
        )
    end
    
    it "should have 2 objects" do
      Job.count.should == 2 
    end
    
    it "should create valid objects" do
      @job.should be_valid
      @job_2.should be_valid
    end
    
    it "should be allowed to update" do
      @job.update_object(
          :employee_id => @employee.id,
          :start_date => DateTime.new(2015,4,8),
          :end_date => DateTime.new(2015,4,18),
          :destination => "Medan"
        )
        
      @job.should be_valid
      
      @job.reload 
    end
    
    it "should be allowed to delete object 2" do
      @job_2.delete_object
      
      @job_2.should be_valid
    end
  end
end
