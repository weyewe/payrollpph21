require 'rails_helper'

RSpec.describe Attendance, type: :model do
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
            :start_working => DateTime.new(2014,1,1)
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
  end
  
  it "should allow object creation with all required field" do
    attendance = Attendance.create_object(
        :employee_id => @employee.id,
        :shift_id => @shift.id,
        :date => DateTime.new(2015,6,20),
        :status => ATTENDANCE_STATUS[:present],
        :time_in => 480,
        :time_out => 1020
      )
      
    attendance.should be_valid
  end
  
  it "should not allow object creation without employee id" do
    attendance = Attendance.create_object( 
        :employee_id =>"",
        :shift_id => @shift.id,
        :date => DateTime.new(2015,6,20),
        :status => ATTENDANCE_STATUS[:present],
        :time_in => 480,
        :time_out => 1020
      )
      
    attendance.should_not be_valid
  end
  
  it "should not allow object creation with invalid employee id" do
    attendance = Attendance.create_object( 
        :employee_id => 0,
        :shift_id => @shift.id,
        :date => DateTime.new(2015,6,20),
        :status => ATTENDANCE_STATUS[:present],
        :time_in => 480,
        :time_out => 1020
      )
      
    attendance.should_not be_valid
  end
  
  it "should allow object creation without shift detail" do
    attendance = Attendance.create_object(
        :employee_id => @employee.id,
        :shift_id => "",
        :date => DateTime.new(2015,6,20),
        :status => ATTENDANCE_STATUS[:present],
        :time_in => 480,
        :time_out => 1020
      )
      
    attendance.should_not be_valid
  end
  
  it "should allow object creation with invalid shift detail" do
    attendance = Attendance.create_object(
        :employee_id => @employee.id,
        :shift_id => 0,
        :date => DateTime.new(2015,6,20),
        :status => ATTENDANCE_STATUS[:present],
        :time_in => 480,
        :time_out => 1020
      )
      
    attendance.should_not be_valid
  end
  
  it "should not allow object creation without date" do
    attendance = Attendance.create_object( 
        :employee_id => @employee.id,
        :shift_id => @shift.id,
        :date => "",
        :status => ATTENDANCE_STATUS[:present],
        :time_in => 480,
        :time_out => 1020
      )
      
    attendance.should_not be_valid
  end
  
  it "should not allow object creation without attendance status" do
    attendance = Attendance.create_object( 
        :employee_id => @employee.id,
        :shift_id => @shift.id,
        :date => DateTime.new(2015,6,20),
        :status => "",
        :time_in => 480,
        :time_out => 1020
      )
      
    attendance.should_not be_valid
  end
  
#   it "should not allow object creation without time in" do
#     attendance = Attendance.create_object( 
#         :employee_id => @employee.id,
#         :shift_id => @shift.id,
#         :date => DateTime.new(2015,6,20),
#         :status => ATTENDANCE_STATUS[:present],
#         :time_in => "",
#         :time_out => 1020
#       )
      
#     attendance.should_not be_valid
#   end
  
#   it "should not allow object creation without time out" do
#     attendance = Attendance.create_object( 
#         :employee_id => @employee.id,
#         :shift_id => @shift.id,
#         :date => DateTime.new(2015,6,20),
#         :status => ATTENDANCE_STATUS[:present],
#         :time_in => 480,
#         :time_out => ""
#       )
      
#     attendance.should_not be_valid
#   end
  
  context "has been created attendance" do
    before(:each) do
      @attendance = Attendance.create_object(
          :employee_id => @employee.id,
          :shift_id => @shift.id,
          :date => DateTime.new(2015,6,20),
          :status => ATTENDANCE_STATUS[:present],
          :time_in => 480,
          :time_out => 1020
        )
        
      @attendance_2 = Attendance.create_object(
          :employee_id => @employee.id,
          :shift_id => @shift.id,
          :date => DateTime.new(2015,6,20),
          :status => ATTENDANCE_STATUS[:present],
          :time_in => 500,
          :time_out => 1040
        )
    end
    
    it "should have 2 objects" do
      Attendance.count.should == 2 
    end
    
    it "should create valid objects" do
      @attendance.should be_valid
      @attendance_2.should be_valid
    end
    
    it "should be allowed to update" do
      @attendance.update_object(
          :employee_id => @employee.id,
          :shift_id => @shift.id,
          :date => DateTime.new(2015,6,20),
          :status => ATTENDANCE_STATUS[:absent],
          :time_in => 480,
          :time_out => 1020
        )
        
      @attendance.should be_valid
      
      @attendance.reload 
      
      @attendance.date.should == DateTime.new(2015,6,20)
      @attendance.status.should == ATTENDANCE_STATUS[:absent]
    end
    
    it "should be allowed to delete object 2" do
      @attendance_2.delete_object
      
      @attendance_2.should be_valid
      
      @attendance_2.is_deleted.should == true
    end
  end
end
