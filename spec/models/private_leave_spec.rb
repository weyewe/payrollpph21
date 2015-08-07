require 'rails_helper'

RSpec.describe PrivateLeave, type: :model do
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
  end
  
  it "should allow object creation with all required field" do
    private_leave = PrivateLeave.create_object(
        :employee_id => @employee.id,
        :date => DateTime.new(2015,2,8),
        :start_time => 900,
        :end_time => 1050,
        :description => "Anak Sakit"
      )
      
    private_leave.should be_valid
    
    private_leave.date.should == DateTime.new(2015,2,8)
    private_leave.start_time.should == 900
    private_leave.end_time.should == 1050
    private_leave.description.should == "Anak Sakit"
  end
  
  it "should not allow object creation without employee id" do
    private_leave = PrivateLeave.create_object( 
        :employee_id => "",
        :date => DateTime.new(2015,2,8),
        :start_time => 900,
        :end_time => 1050,
        :description => "Anak Sakit"
      )
      
    private_leave.should_not be_valid
  end
  
  it "should not allow object creation with invalid employee id" do
    private_leave = PrivateLeave.create_object( 
        :employee_id => 0,
        :date => DateTime.new(2015,2,8),
        :start_time => 900,
        :end_time => 1050,
        :description => "Anak Sakit"
      )
      
    private_leave.should_not be_valid
  end
  
  it "should not allow object creation without date" do
    private_leave = PrivateLeave.create_object( 
        :employee_id => @employee.id,
        :date => "",
        :start_time => 900,
        :end_time => 1050,
        :description => "Anak Sakit"
      )
      
    private_leave.should_not be_valid
  end
  
  it "should not allow object creation without start time" do
    private_leave = PrivateLeave.create_object( 
        :employee_id => @employee.id,
        :date => DateTime.new(2015,2,8),
        :start_time => "",
        :end_time => 1050,
        :description => "Anak Sakit"
      )
      
    private_leave.should_not be_valid
  end
  
  it "should not allow object creation with invalid start time" do
    private_leave = PrivateLeave.create_object( 
        :employee_id => @employee.id,
        :date => DateTime.new(2015,2,8),
        :start_time => -1,
        :end_time => 1050,
        :description => "Anak Sakit"
      )
      
    private_leave.should_not be_valid
  end
  
  it "should not allow object creation with invalid start time" do
    private_leave = PrivateLeave.create_object( 
        :employee_id => @employee.id,
        :date => DateTime.new(2015,2,8),
        :start_time => 1445,
        :end_time => 1050,
        :description => "Anak Sakit"
      )
      
    private_leave.should_not be_valid
  end
  
  it "should not allow object creation without end time" do
    private_leave = PrivateLeave.create_object( 
        :employee_id => @employee.id,
        :date => DateTime.new(2015,2,8),
        :start_time => 900,
        :end_time => "",
        :description => "Anak Sakit"
      )
      
    private_leave.should_not be_valid
  end
  
  
  it "should not allow object creation with invalid end time" do
    private_leave = PrivateLeave.create_object( 
        :employee_id => @employee.id,
        :date => DateTime.new(2015,2,8),
        :start_time => 900,
        :end_time => -1,
        :description => "Anak Sakit"
      )
      
    private_leave.should_not be_valid
  end
  
  it "should not allow object creation with invalid end time" do
    private_leave = PrivateLeave.create_object( 
        :employee_id => @employee.id,
        :date => DateTime.new(2015,2,8),
        :start_time => 900,
        :end_time => 1445,
        :description => "Anak Sakit"
      )
      
    private_leave.should_not be_valid
  end
  
  
  it "should not allow object creation without description" do
    private_leave = PrivateLeave.create_object( 
        :employee_id => @employee.id,
        :date => DateTime.new(2015,2,8),
        :start_time => 900,
        :end_time => 1050,
        :description => ""
      )
      
    private_leave.should_not be_valid
  end
  
  context "has been created private_leave" do
    before(:each) do
      @private_leave = PrivateLeave.create_object(
          :employee_id => @employee.id,
          :date => DateTime.new(2015,2,8),
          :start_time => 900,
          :end_time => 1050,
          :description => "Anak Sakit"
        )
        
      @private_leave_2 = PrivateLeave.create_object(
          :employee_id => @employee.id,
          :date => DateTime.new(2015,6,22),
          :start_time => 48,
          :end_time => 630,
          :description => "Ban Bocor"
        )
    end
    
    it "should have 2 objects" do
      PrivateLeave.count.should == 2 
    end
    
    it "should create valid objects" do
      @private_leave.should be_valid
      @private_leave_2.should be_valid
    end
    
    it "should be allowed to update" do
      @private_leave.update_object(
          :employee_id => @employee.id,
          :date => DateTime.new(2015,3,8),
          :start_time => 900,
          :end_time => 1050,
          :description => "Ibu Sakit"
        )
        
      @private_leave.should be_valid
      
      @private_leave.reload 
      
      @private_leave.date.should == DateTime.new(2015,3,8)
      @private_leave.start_time.should == 900
      @private_leave.end_time.should == 1050
      @private_leave.description.should == "Ibu Sakit"
    end
    
    it "should be allowed to delete object 2" do
      @private_leave_2.delete_object
      
      @private_leave_2.should be_valid
      
      @private_leave_2.is_deleted.should be_truthy
    end
    
    context "has been deleted private leave" do
        before(:each) do
            @private_leave_2.delete_object
        end
        
        it "should delete valid object" do
            @private_leave_2.should be_valid
        end
        
        it "should be allowed to create object 3" do
          @private_leave_3 = PrivateLeave.create_object(
              :employee_id => @employee.id,
              :date => DateTime.new(2015,6,22),
              :start_time => 480,
              :end_time => 630,
              :description => "Ban Bocor"
            )
          
          @private_leave_3.should be_valid
          
          @private_leave_3.date.should == DateTime.new(2015,6,22)
          @private_leave_3.start_time.should == 480
          @private_leave_3.end_time.should == 630
          @private_leave_3.description.should == "Ban Bocor"
        end
    end
    
    context "has been approved private leave" do
        before(:each) do
            @private_leave_2.approve_object
        end
        
        it "should update valid object" do
            @private_leave_2.should be_valid
        end
        
        it "should be allowed to unapprove object 2" do
          @private_leave_2.unapprove_object
          
          @private_leave_2.should be_valid
          
          @private_leave_2.is_approved.should be_falsy
        end 
    end
    
  end
end
