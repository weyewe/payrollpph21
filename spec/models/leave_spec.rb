require 'rails_helper'

RSpec.describe Leave, type: :model do
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
            :start_working => DateTime.new(2013,3,1)
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
      
      @leave_detail = LeaveDetail.create_object(
            :employee_id => @employee.id,
            :start_working => DateTime.new(2013,1,1),
            :period_year => 2015,
            :start_period => DateTime.new(2015,1,1),
            :end_period => DateTime.new(2015,12,31),
            :max_leave => 12,
            :used_leave => 7,
            :current_leave => 5
         )
  end
  
  it "should allow object creation with all required field" do
    leave = Leave.create_object(
        :employee_id => @employee.id,
        :date => DateTime.new(2015,2,8),
        :description => "Anak Sakit"
      )
      
    leave.should be_valid
  end
  
  it "should not allow object creation without employee id" do
    leave = Leave.create_object( 
        :employee_id => "",
        :date => DateTime.new(2015,2,8),
        :description => "Anak Sakit"
      )
      
    leave.should_not be_valid
  end
  
  it "should not allow object creation with invalid employee id" do
    leave = Leave.create_object( 
        :employee_id => 0,
        :date => DateTime.new(2015,2,8),
        :description => "Anak Sakit"
      )
      
    leave.should_not be_valid
  end
  
  it "should not allow object creation without date" do
    leave = Leave.create_object( 
        :employee_id => @employee.id,
        :date => "",
        :description => "Anak Sakit"
      )
      
    leave.should_not be_valid
  end
  
  it "should not allow object creation without description" do
    leave = Leave.create_object( 
        :employee_id => @employee.id,
        :date => DateTime.new(2015,2,8),
        :description => ""
      )
      
    leave.should_not be_valid
  end
  
  it "should allow generate leave summary" do
    leave = Leave.generate_object(
          :office_id => @office.id,
          :date => DateTime.new(2015,2,8)
        )
  end
  
  context "has been created leave" do
    before(:each) do
      @leave = Leave.create_object(
          :employee_id => @employee.id,
          :date => DateTime.new(2015,2,8),
          :description => "Anak Sakit"
        )
        
      @leave_2 = Leave.create_object(
          :employee_id => @employee.id,
          :date => DateTime.new(2015,6,22),
          :description => "Saudara Meninggal"
        )
    end
    
    it "should have 2 objects" do
      Leave.count.should == 2 
    end
    
    it "should create valid objects" do
      @leave.should be_valid
      @leave_2.should be_valid
    end
    
    it "should be allowed to update" do
      @leave.update_object(
          :employee_id => @employee.id,
          :date => DateTime.new(2015,3,8),
          :description => "Ibu Sakit"
        )
        
      @leave.should be_valid
      
      @leave.reload 
    end
    
    it "should be allowed to delete object 2" do
      @leave_2.delete_object
      
      @leave_2.should be_valid
    end
    
    it "should not be allowed to unapprove object 2" do
      @leave_2.unapprove_object
      
      @leave_2.should be_valid
    end
    
    context "has been deleted leave" do
        before(:each) do
            @leave_2.delete_object
        end
        
        it "should delete valid object" do
            @leave_2.should be_valid
        end
        
        it "should be allowed to create object 3" do
          @leave_3 = Leave.create_object(
              :employee_id => @employee.id,
              :date => DateTime.new(2015,6,22),
              :description => "Ban Bocor"
            )
          
          @leave_3.should be_valid
        end
    end
    
    context "has been approved private leave" do
        before(:each) do
            @leave_2.approve_object
        end
        
        it "should update valid object" do
            @leave_2.should be_valid
        end
        
        it "should be allowed to delete object 2" do
          @leave_2.delete_object
          
          @leave_2.should be_valid
        end
        
        it "should be allowed to unapprove object 2" do
          @leave_2.unapprove_object
          
          @leave_2.should be_valid
        end 
    end
    
  end
end
