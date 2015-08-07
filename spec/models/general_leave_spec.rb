require 'rails_helper'

RSpec.describe GeneralLeave, type: :model do
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
            :bank_id => @bank.id,
            :no_jamsostek => "JamsostekNumber",
            :jamsostek_registered_date => DateTime.new(2015,1,1),
            :start_working => DateTime.new(2014,1,1)
          )
      
      @generate_leave = Leave.generate_object(
            :date => DateTime.now,
            :office_id => @office.id
          )
      
      @shift = Shift.create_object(
            :office_id => @office.id,
            :code => "SFT",
            :name => "SHIFT",
            :start_time => 480,
            :duration => 8
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
      
      @shift_allocation = ShiftAllocation.create_object(
            :shift_id => @shift.id ,
            :employee_id => @employee.id
         )
  end
  
  it "should allow object creation with all required field" do
    date = DateTime.new(2015,8,17)
    general_leave = GeneralLeave.create_object(
        :office_id => @office.id,
        :date => date,
        :description => "Hari Kemerdekaan"
      )
      
    general_leave.should be_valid
    
    general_leave.date.should == date
  end
  
  it "should not allow object creation without office id" do
    date = DateTime.new(2015,8,17)
    general_leave = GeneralLeave.create_object( 
        :office_id => "",
        :date => date,
        :description => "Hari Kemerdekaan"
      )
      
    general_leave.should_not be_valid
  end
  
  it "should not allow object creation with invalid office id" do
    date = DateTime.new(2015,8,17)
    general_leave = GeneralLeave.create_object( 
        :office_id => 0,
        :date => date,
        :description => "Hari Kemerdekaan"
      )
      
    general_leave.should_not be_valid
  end
  
  it "should not allow object creation without description" do
    date = DateTime.new(2015,8,17)
    general_leave = GeneralLeave.create_object( 
        :office_id => @office.id,
        :date => date,
        :description => ""
      )
      
    general_leave.should_not be_valid
  end
  
  it "should not allow object creation without date" do
    date = DateTime.new(2015,8,17)
    general_leave = GeneralLeave.create_object( 
        :office_id => @office.id,
        :date => "",
        :description => "Hari Kemerdekaan"
      )
      
    general_leave.should_not be_valid
  end
  
  it "should not allow object creation with duplicate date" do
    date = DateTime.new(2015,8,17)
    general_leave =  GeneralLeave.create_object( 
        :office_id => @office.id,
        :date =>  date,
        :description => "Hari Kemerdekaan"
      )
      
    general_leave.should be_valid
    
    general_leave_2 = GeneralLeave.create_object( 
        :office_id => @office.id,
        :date =>  date,
        :description => "Hari Kemerdekaan Tbk"
      )
      
    general_leave_2.should_not be_valid
  end
  
  context "has been created general_leave" do
    before(:each) do
      @general_leave_1_date = DateTime.new(2015,8,17)
      @general_leave_1_description = "Hari Kemerdekaan"
      @general_leave = GeneralLeave.create_object(
          :office_id => @office.id,
          :date =>  @general_leave_1_date,
          :description =>  @general_leave_1_description
        )
        
      @general_leave_2_date = DateTime.new(2015,7,17)
      @general_leave_2_description = "Idul Fitri"
      @general_leave_2 = GeneralLeave.create_object(
          :office_id => @office.id,
          :date => @general_leave_2_date,
          :description => @general_leave_2_description
        )
    end
    
    it "should have 2 objects" do
      GeneralLeave.count.should == 2 
    end
    
    it "should create valid objects" do
      @general_leave.should be_valid
      @general_leave_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_date = DateTime.new(2015,8,18)
      new_description = "Idul Fitri"
      
      @general_leave.update_object(
          :office_id => @office.id,
          :date => new_date,
          :description => new_description
        )
        
      @general_leave.should be_valid
      
      @general_leave.reload 
      
      @general_leave.description.should == new_description
      @general_leave.date.should == new_date
    end
    
    it "should not allow duplicate date" do
      @general_leave_2.update_object(
          :office_id => @office.id,
          :date => @general_leave_1_date,
          :description => @general_leave_2_description
        )
        
      @general_leave_2.errors.size.should_not == 0 
      @general_leave_2.should_not be_valid
    end
    
    it "should be allowed to delete object 2" do
      @general_leave_2.delete_object
      
      @general_leave_2.persisted?.should be_falsy  # be_truthy 
      
      GeneralLeave.count.should == 1 
    end
    
    it "should have 1 attendance with status general leave" do
      current_employee_id = @employee.id
      obj_attendance = Attendance.where{
        (employee_id.eq current_employee_id) & 
        (strftime("%Y-%m-%d",date).eq DateTime.new(2015,8,17).to_date) & 
        (status.eq ATTENDANCE_STATUS[:general_leave]) & 
        (is_deleted.eq false)
      }
      
      obj_attendance.count.should == 1
    end
    
    it "should have attendance data with status general leave" do
      current_employee_id = @employee.id
      obj_attendance = Attendance.where{
        (employee_id.eq current_employee_id) & 
        (strftime("%Y-%m-%d",date).eq DateTime.new(2015,8,17).to_date) & 
        (status.eq ATTENDANCE_STATUS[:general_leave]) & 
        (is_deleted.eq false)
      }.first
      
      obj_attendance.date.should == DateTime.new(2015,8,17)
      obj_attendance.status == ATTENDANCE_STATUS[:general_leave]
    end
    
    it "should leave detail minus 2 leave" do
      current_employee_id = @employee.id
      obj_leave_detail = LeaveDetail.where{
            (employee_id.eq current_employee_id) &
            ((strftime("%Y-%m-%d",start_period).lte DateTime.new(2015,8,17).to_date) &
                (strftime("%Y-%m-%d",end_period).gte DateTime.new(2015,8,17).to_date))
        }.first
      
      obj_leave_detail.used_leave.should == 2
      obj_leave_detail.current_leave.should == 10
    end
    
    context "has been deleted object" do
        before(:each) do
            @general_leave_2.delete_object
        end
        
        it "should have deleted object" do
            @general_leave_2.should be_valid
        end
        
        it "should have 0 attendance with status general leave" do
          current_employee_id = @employee.id
          obj_attendance = Attendance.where{
            (employee_id.eq current_employee_id) & 
            (strftime("%Y-%m-%d",date).eq DateTime.new(2015,7,17).to_date) & 
            (status.eq ATTENDANCE_STATUS[:general_leave]) & 
            (is_deleted.eq false)
          }
          
          obj_attendance.count.should == 0
        end
        
        it "should leave detail plus 1 leave" do
          current_employee_id = @employee.id
          obj_leave_detail = LeaveDetail.where{
                (employee_id.eq current_employee_id) &
                ((strftime("%Y-%m-%d",start_period).lte DateTime.new(2015,7,17).to_date) &
                    (strftime("%Y-%m-%d",end_period).gte DateTime.new(2015,7,17).to_date))
            }.first
          
          obj_leave_detail.used_leave.should == 1
          obj_leave_detail.current_leave.should == 11
        end
    end
  end
end
