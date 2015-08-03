require 'rails_helper'

RSpec.describe TrainingDetail, type: :model do
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
            :bank_id => @bank.id
          )
          
      @training = Training.create_object(
            :office_id => @office.id,
            :subject => "Leadership",
            :start_date => DateTime.new(2015,1,1),
            :end_date => DateTime.new(2015,1,5)
          )
          
      @training_2 = Training.create_object(
            :office_id => @office.id,
            :subject => "Leadership",
            :start_date => DateTime.new(2015,1,1),
            :end_date => DateTime.new(2015,1,5)
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
      
      @shift_allocation_2 = ShiftAllocation.create_object(
          :shift_id => @shift.id ,
          :employee_id => @employee_2.id
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
  
  it "should create training and employee" do
    @training.should be_valid
    @training_2.should be_valid
    @employee.should be_valid
    @employee_2.should be_valid
  end
      
  it "should create training allocation with training id and employee id" do
      training_detail = TrainingDetail.create_object(
          :training_id => @training.id ,
          :employee_id => @employee.id
          )
          
      training_detail.persisted?.should be_truthy
      
      training_detail.should be_valid
      
      training_detail.training_id.should == @training.id
      training_detail.employee_id.should == @employee.id
  end

  it "should create training allocation with training id exist" do
      training_detail = TrainingDetail.create_object(
          :training_id => 0,
          :employee_id => @employee.id
          )
      
      training_detail.errors.size.should_not == 0 
      training_detail.should_not be_valid 
  end
  
  it "should create training allocation with employee id exist" do
      training_detail = TrainingDetail.create_object(
          :training_id => @training.id,
          :employee_id => 0
          )
      
      training_detail.errors.size.should_not == 0 
      training_detail.should_not be_valid 
  end
  
  it "should not create training allocation with training_id and employee_id duplicate" do
      training_detail = TrainingDetail.create_object(
          :training_id => @training.id,
          :employee_id => @employee.id
          )
      
      training_detail.should be_valid
      
      training_detail_2 = TrainingDetail.create_object(
          :training_id => @training.id,
          :employee_id => @employee.id
          )
      
      training_detail_2.should_not be_valid
  end
  
  context "jika training sudah ada" do
      before (:each) do
          @training_detail = TrainingDetail.create_object(
              :training_id => @training.id,
              :employee_id => @employee.id
              )
          
          @training_detail_2 = TrainingDetail.create_object(
              :training_id => @training_2.id,
              :employee_id => @employee_2.id
              )
      end
      
      it "should not update training allocation with training id and employee id" do
            @training_detail.update_object(
                  :training_id => @training.id,
                  :employee_id => @employee_2.id
                  )
              
            @training_detail.should be_valid
              
            @training_detail.reload
              
            @training_detail.training_id.should == @training.id
            @training_detail.employee_id.should == @employee_2.id
            
      end
      
      it "should not duplicate training id and employee id" do
          @training_detail_2.update_object(
                  :training_id => @training.id,
                  :employee_id => @employee.id
                  )
         
          @training_detail_2.should_not be_valid
      end
      context "deleted one training allocation" do
          before(:each) do
              @training_detail.delete_object
              @training_detail.should be_valid
          end
          
          it "should have deleted training allocation" do
              @training_detail.is_deleted.should be_truthy
          end
          
          it "should be allowed to create another training allocation with same data" do
             @training_detail_2 = TrainingDetail.create_object(
                  :training_id => @training_detail.training_id,
                  :employee_id => @training_detail.employee_id
                  )
          
             @training_detail_2.should be_valid
          end
          
      end
  end
end
