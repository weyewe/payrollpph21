require 'rails_helper'

RSpec.describe OvertimeAllocation, type: :model do
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
          
      @overtime = Overtime.create_object(
            :office_id => @office.id,
            :code => "HK",
            :name => "Overtime di Hari Kerja"
          )
  end
  
  it "should allow object creation with all required field" do
    overtime_allocation = OvertimeAllocation.create_object(
        :employee_id => @employee.id,
        :overtime_id => @overtime.id,
        :date => DateTime.new(2015,2,8),
        :start_time => 1080,
        :end_time => 1260,
        :description => "Overtime"
      )
      
    overtime_allocation.should be_valid
  end
  
  it "should not allow object creation without employee id" do
    overtime_allocation = OvertimeAllocation.create_object( 
        :employee_id => "",
        :overtime_id => @overtime.id,
        :date => DateTime.new(2015,2,8),
        :start_time => 1080,
        :end_time => 1260,
        :description => "Overtime"
      )
      
    overtime_allocation.should_not be_valid
  end
  
  it "should not allow object creation with invalid employee id" do
    overtime_allocation = OvertimeAllocation.create_object( 
        :employee_id => 0,
        :overtime_id => @overtime.id,
        :date => DateTime.new(2015,2,8),
        :start_time => 1080,
        :end_time => 1260,
        :description => "Overtime"
      )
      
    overtime_allocation.should_not be_valid
  end
  
  it "should not allow object creation without overtime id" do
    overtime_allocation = OvertimeAllocation.create_object( 
        :employee_id => @employee.id,
        :overtime_id => "",
        :date => DateTime.new(2015,2,8),
        :start_time => 1080,
        :end_time => 1260,
        :description => "Overtime"
      )
      
    overtime_allocation.should_not be_valid
  end
  
  it "should not allow object creation with invalid overtime id" do
    overtime_allocation = OvertimeAllocation.create_object( 
        :employee_id => @employee.id,
        :overtime_id => 0,
        :date => DateTime.new(2015,2,8),
        :start_time => 1080,
        :end_time => 1260,
        :description => "Overtime"
      )
      
    overtime_allocation.should_not be_valid
  end
  
  it "should not allow object creation without date" do
    overtime_allocation = OvertimeAllocation.create_object( 
        :employee_id => @employee.id,
        :overtime_id => @overtime.id,
        :date => "",
        :start_time => 1080,
        :end_time => 1260,
        :description => "Overtime"
      )
      
    overtime_allocation.should_not be_valid
  end
  
  it "should not allow object creation without start time" do
    overtime_allocation = OvertimeAllocation.create_object( 
        :employee_id => @employee.id,
        :overtime_id => @overtime.id,
        :date => DateTime.new(2015,2,8),
        :start_time => "",
        :end_time => 1260,
        :description => "Overtime"
      )
      
    overtime_allocation.should_not be_valid
  end
  
  it "should not allow object creation without end time" do
    overtime_allocation = OvertimeAllocation.create_object( 
        :employee_id => @employee.id,
        :overtime_id => @overtime.id,
        :date => DateTime.new(2015,2,8),
        :start_time => 1080,
        :end_time => "",
        :description => "Overtime"
      )
      
    overtime_allocation.should_not be_valid
  end
  
  it "should not allow object creation without description" do
    overtime_allocation = OvertimeAllocation.create_object( 
        :employee_id => @employee.id,
        :overtime_id => @overtime.id,
        :date => DateTime.new(2015,2,8),
        :start_time => 1080,
        :end_time => 1260,
        :description => ""
      )
      
    overtime_allocation.should_not be_valid
  end
  
  context "has been created overtime_allocation" do
    before(:each) do
      @overtime_allocation = OvertimeAllocation.create_object(
          :employee_id => @employee.id,
          :overtime_id => @overtime.id,
          :date => DateTime.new(2015,2,8),
          :start_time => 1080,
          :end_time => 1260,
          :description => "Overtime"
        )
        
      @overtime_allocation_2 = OvertimeAllocation.create_object(
          :employee_id => @employee.id,
          :overtime_id => @overtime.id,
          :date => DateTime.new(2015,6,22),
          :start_time => 1110,
          :end_time => 1260,
          :description => "Ban Bocor"
        )
    end
    
    it "should have 2 objects" do
      OvertimeAllocation.count.should == 2 
    end
    
    it "should create valid objects" do
      @overtime_allocation.should be_valid
      @overtime_allocation_2.should be_valid
    end
    
    it "should be allowed to update" do
      @overtime_allocation.update_object(
          :employee_id => @employee.id,
          :overtime_id => @overtime.id,
          :date => DateTime.new(2015,3,8),
          :start_time => 1140,
          :end_time => 1260,
          :description => "-"
        )
        
      @overtime_allocation.should be_valid
      
      @overtime_allocation.reload 
    end
    
    it "should be allowed to delete object 2" do
      @overtime_allocation_2.delete_object
      
      @overtime_allocation_2.should be_valid
    end
    
    it "should not be allowed to unapprove object 2" do
      @overtime_allocation_2.unapprove_object
      
      @overtime_allocation_2.should be_valid
    end
    
    context "has been deleted private leave" do
        before(:each) do
            @overtime_allocation_2.delete_object
        end
        
        it "should delete valid object" do
            @overtime_allocation_2.should be_valid
        end
        
        it "should be allowed to create object 3" do
          @overtime_allocation_3 = OvertimeAllocation.create_object(
              :employee_id => @employee.id,
              :overtime_id => @overtime.id,
              :date => DateTime.new(2015,6,22),
              :start_time => 1140,
              :end_time => 1260,
              :description => "Ban Bocor"
            )
          
          @overtime_allocation_3.should be_valid
        end
    end
    
    context "has been approved private leave" do
        before(:each) do
            @overtime_allocation_2.approve_object
        end
        
        it "should update valid object" do
            @overtime_allocation_2.should be_valid
        end
        
        it "should be allowed to delete object 2" do
          @overtime_allocation_2.delete_object
          
          @overtime_allocation_2.should be_valid
        end
        
        it "should be allowed to unapprove object 2" do
          @overtime_allocation_2.unapprove_object
          
          @overtime_allocation_2.should be_valid
        end 
    end
    
  end
end
