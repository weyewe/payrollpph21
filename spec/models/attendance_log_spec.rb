require 'rails_helper'

RSpec.describe AttendanceLog, type: :model do
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
      
      @employee_2 = Employee.create_object(
            :office_id => @office.id,
            :branch_office_id => @branch_office.id,
            :department_id => @department.id,
            :division_id => @division.id,
            :title_id => @title.id,
            :level_id => @level.id,
            :status_working_id => @status_working.id,
            :code => "008",
            :full_name => "Abdul Ro'uf",
            :nick_name => "Abdul",
            :enroll_id => 13,
            :bank_id => @bank.id,
            :start_working => DateTime.new(2014,1,1)
          )
      
      @shift = Shift.create_object(
            :office_id => @office.id,
            :code => "SFT",
            :name => "SHIFT",
            :start_time => 510,
            :duration => 8
          )
      
      @shift_allocation = ShiftAllocation.create_object(
            :shift_id => @shift.id ,
            :employee_id => @employee.id
          )
      
      @shift_allocation_2 = ShiftAllocation.create_object(
            :shift_id => @shift.id ,
            :employee_id => @employee_2.id
          )
          
      @shift_detail = ShiftDetail.create_object(
            :shift_id => @shift.id,
            :day_code => DAY_CODE[:sunday],
            :start_time => 510,
            :duration => 8
         )
      
      @shift_detail_2 = ShiftDetail.create_object(
            :shift_id => @shift.id,
            :day_code => DAY_CODE[:monday],
            :start_time => 510,
            :duration => 8
         )
      
      @shift_detail_3 = ShiftDetail.create_object(
            :shift_id => @shift.id,
            :day_code => DAY_CODE[:tuesday],
            :start_time => 510,
            :duration => 8
         )
      
      @shift_detail_4 = ShiftDetail.create_object(
            :shift_id => @shift.id,
            :day_code => DAY_CODE[:wednesday],
            :start_time => 510,
            :duration => 8
         )
      
      @shift_detail_5 = ShiftDetail.create_object(
            :shift_id => @shift.id,
            :day_code => DAY_CODE[:thursday],
            :start_time => 510,
            :duration => 8
         )
      
      @shift_detail_6 = ShiftDetail.create_object(
            :shift_id => @shift.id,
            :day_code => DAY_CODE[:friday],
            :start_time => 510,
            :duration => 8
         )
      
      @shift_detail_7 = ShiftDetail.create_object(
            :shift_id => @shift.id,
            :day_code => DAY_CODE[:saturday],
            :start_time => 510,
            :duration => 6
         )
  end
  
  it "should allow object creation with all requirement field" do
    attendance_log = AttendanceLog.create_object(
        :office_id => @office.id,
        :date => DateTime.new(2015,7,1,8,30,0),
        :enroll_id => 12,
        :in_out => 0
      )
      
    attendance_log.should be_valid
  end
  
  it "should not allow object creation without office id" do
    attendance_log = AttendanceLog.create_object( 
        :office_id => "",
        :date => DateTime.new(2015,7,1,8,30,0),
        :enroll_id => 12,
        :in_out => 0
      )
      
    attendance_log.should_not be_valid
  end
  
  it "should not allow object creation with invalid office id" do
    attendance_log = AttendanceLog.create_object( 
        :office_id => 0,
        :date => DateTime.new(2015,7,1,8,30,0),
        :enroll_id => 12,
        :in_out => 0
      )
      
    attendance_log.should_not be_valid
  end
  
  it "should not allow object creation without date" do
    attendance_log = AttendanceLog.create_object( 
        :office_id => @office.id,
        :date => "",
        :enroll_id => 12,
        :in_out => 0
      )
      
    attendance_log.should_not be_valid
  end
  
  it "should not allow object creation without enroll id" do
    attendance_log = AttendanceLog.create_object( 
        :office_id => @office.id,
        :date => DateTime.new(2015,7,1,8,30,0),
        :enroll_id => "",
        :in_out => 0
      )
      
    attendance_log.should_not be_valid
  end
  
  it "should not allow object creation without in out" do
    attendance_log = AttendanceLog.create_object( 
        :office_id => @office.id,
        :date => DateTime.new(2015,7,1,8,30,0),
        :enroll_id => 12,
        :in_out => ""
      )
      
    attendance_log.should_not be_valid
  end
  
  context "has been created attendance_log" do
    before(:each) do
      @attendance_log = AttendanceLog.create_object(
          :office_id => @office.id,
          :date => DateTime.new(2015,7,1,8,30,0),
          :enroll_id => 12,
          :in_out => 0
        )
      
      @attendance_log_3 = AttendanceLog.create_object(
          :office_id => @office.id,
          :date => DateTime.new(2015,7,1,17,00,0),
          :enroll_id => 12,
          :in_out => 1
        )
        
      @attendance_log_2 = AttendanceLog.create_object(
          :office_id => @office.id,
          :date => DateTime.new(2015,7,1,8,40,0),
          :enroll_id => 13,
          :in_out => 0
        )
    end
    
    it "should have 2 objects" do
      AttendanceLog.count.should == 3
    end
    
    it "should create valid objects" do
      @attendance_log.should be_valid
      @attendance_log_2.should be_valid
    end
    
    it "should be allowed to update" do
      @attendance_log.update_object(
          :office_id => @office.id,
          :date => DateTime.new(2015,7,1,8,40,0),
          :enroll_id => 12,
          :in_out => 0
        )
        
      @attendance_log.should be_valid
      
      @attendance_log.reload
      
      @attendance_log.date.should == DateTime.new(2015,7,1,8,40,0)
      @attendance_log.enroll_id.should == 12
      @attendance_log.in_out.should == 0
    end
    
    it "should be allowed to delete object 2" do
      @attendance_log_2.delete_object
      
      @attendance_log_2.persisted?.should be_falsy  # be_truthy 
      
      AttendanceLog.count.should == 2 
    end
    
    it "should attendance have 1 row" do
        current_employee_id = @employee.id
        
        obj_attendance = Attendance.where{
            (employee_id.eq current_employee_id) &
            (strftime("%Y-%m-%d",date).eq DateTime.new(2015,7,1,8,30,0).to_date)
        }
        
        obj_attendance.count.should == 1
    end
    
    it "should attendance have time in == 520 for first data" do
        current_employee_id = @employee.id
        
        obj_attendance = Attendance.where{
            (employee_id.eq current_employee_id) &
            (strftime("%Y-%m-%d",date).eq DateTime.new(2015,7,1,8,30,0).to_date)
        }.first
        
        obj_attendance.time_in.should == 510
        obj_attendance.time_out.should == 1020
        obj_attendance.shift_id.should == @shift.id
        obj_attendance.is_late.should == false
        obj_attendance.status.should == ATTENDANCE_STATUS[:present]
    end
    
    it "should attendance have time in == 520 for second data" do
        current_employee_id = @employee_2.id
        
        obj_attendance = Attendance.where{
            (employee_id.eq current_employee_id) &
            (strftime("%Y-%m-%d",date).eq DateTime.new(2015,7,1,8,40,0).to_date)
        }.first
        
        obj_attendance.time_in.should == 520
        obj_attendance.shift_id.should == @shift.id
        obj_attendance.is_late.should == true
        obj_attendance.late_minute.should == 10
        obj_attendance.status.should == ATTENDANCE_STATUS[:present]
    end
  end
end
