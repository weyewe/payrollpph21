require 'rails_helper'

RSpec.describe ShiftAllocation, type: :model do
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
            :full_name => "Bambang",
            :nick_name => "Bams",
            :enroll_id => 14,
            :bank_id => @bank.id,
            :start_working => DateTime.new(2014,1,1)
          )
      @shift = Shift.create_object(
            :office_id => @office.id,
            :name => "SHIFT 1",
            :code => "sft01",
            :start_time => 480,
            :duration => 8
          )
          
      @shift_2 = Shift.create_object(
            :office_id => @office.id,
            :name => "SHIFT 2",
            :code => "sft02",
            :start_time => 540,
            :duration => 8
          )
  end  
  
  it "should create shift and employee" do
    @shift.should be_valid
    @shift_2.should be_valid
    @employee.should be_valid
    @employee_2.should be_valid
  end
      
  it "should create shift allocation with shift id and employee id" do
      shift_allocation = ShiftAllocation.create_object(
          :shift_id => @shift.id ,
          :employee_id => @employee.id
          )
          
      shift_allocation.persisted?.should be_truthy
      
      shift_allocation.should be_valid
      
      shift_allocation.shift_id.should == @shift.id
      shift_allocation.employee_id.should == @employee.id
  end

  it "should create shift allocation with shift id exist" do
      shift_allocation = ShiftAllocation.create_object(
          :shift_id => 0,
          :employee_id => @employee.id
          )
      
      shift_allocation.errors.size.should_not == 0 
      shift_allocation.should_not be_valid 
  end
  
  it "should create shift allocation with employee id exist" do
      shift_allocation = ShiftAllocation.create_object(
          :shift_id => @shift.id,
          :employee_id => 0
          )
      
      shift_allocation.errors.size.should_not == 0 
      shift_allocation.should_not be_valid 
  end
  
  it "should not create shift allocation with shift_id and employee_id duplicate" do
      shift_allocation = ShiftAllocation.create_object(
          :shift_id => @shift.id,
          :employee_id => @employee.id
          )
      
      shift_allocation.should be_valid
      
      shift_allocation_2 = ShiftAllocation.create_object(
          :shift_id => @shift.id,
          :employee_id => @employee.id
          )
      
      shift_allocation_2.should_not be_valid
  end
  
  context "jika shift sudah ada" do
      before (:each) do
          @shift_allocation = ShiftAllocation.create_object(
              :shift_id => @shift.id,
              :employee_id => @employee.id
              )
          
          @shift_allocation_2 = ShiftAllocation.create_object(
              :shift_id => @shift_2.id,
              :employee_id => @employee_2.id
              )
      end
      
      it "should not update shift allocation with shift id and employee id" do
            @shift_allocation.update_object(
                  :shift_id => @shift.id,
                  :employee_id => @employee_2.id
                  )
              
            @shift_allocation.should be_valid
              
            @shift_allocation.reload
              
            @shift_allocation.shift_id.should == @shift.id
            @shift_allocation.employee_id.should == @employee_2.id
            
      end
      
      it "should not duplicate shift id and employee id" do
          @shift_allocation_2.update_object(
                  :shift_id => @shift.id,
                  :employee_id => @employee.id
                  )
         
          @shift_allocation_2.should_not be_valid
      end
      
      it "should be allow to delete shift_allocation " do
          @shift_allocation.update_object(
                  :shift_id => @shift.id,
                  :employee_id => @employee.id,
                  :is_deleted => true,
                  :deleted_at => DateTime.now
                  )
          
          @shift_allocation.should be_valid
          
      end
      
    #   it "should be allow to create after delete shift_allocation" do
    #       @shift_allocation.delete_object
          
          
    #       @shift_allocation.should be_valid
          
    #     #   @shift_allocation_2 = ShiftAllocation.create_object(
    #     #       :shift_id => @shift.id,
    #     #       :employee_id => @employee.id
    #     #       )
          
    #     #   @shift_allocation_2.should be_valid
    #   end
      
      context "deleted one shift allocation" do
          before(:each) do
              @shift_allocation.delete_object
              @shift_allocation.should be_valid
          end
          
          it "should have deleted shift allocation" do
              @shift_allocation.is_deleted.should be_truthy
          end
          
          it "should be allowed to create another shift allocation with same data" do
             @shift_allocation_2 = ShiftAllocation.create_object(
                  :shift_id => @shift_allocation.shift_id,
                  :employee_id => @shift_allocation.employee_id
                  )
          
             @shift_allocation_2.should be_valid
             
             @shift_allocation_2.shift_id.should == @shift_allocation.shift_id
             @shift_allocation_2.employee_id.should == @shift_allocation.employee_id
          end
          
      end
  end
  
  
end
