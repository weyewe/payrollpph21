require 'rails_helper'

RSpec.describe Pkwt, type: :model do
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
    
      @recruitment = Recruitment.create_object(
        :office_id => @office.id,
        :branch_office_id => @branch_office.id,
        :department_id => @department.id,
        :division_id => @division.id,
        :title_id => @title.id,
        :level_id => @level.id,
        :status_working_id => @status_working.id,
        :identity_number => "1234567890",
        :name => "Pebrian"
      )
  end
  
  it "should allow object creation with all required field from employee" do
    no = "1234567890"
    pkwt = Pkwt.create_object(
        :office_id => @office.id,
        :no => no,
        :is_employee => true,
        :employee_id => @employee.id,
        :length_of_contract => 3,
        :start_date => DateTime.new(2015,01,01),
        :end_date => DateTime.new(2015,03,30)
      )
      
    pkwt.should be_valid
    
    pkwt.no.should == no
  end
  
  it "should allow object creation with all required field from recruitment" do
    no = "1234567890"
    pkwt = Pkwt.create_object(
        :office_id => @office.id,
        :no => no,
        :is_employee => false,
        :employee_id => @recruitment.id,
        :length_of_contract => 3,
        :start_date => DateTime.new(2015,01,01),
        :end_date => DateTime.new(2015,03,30)
      )
      
    pkwt.should be_valid
    
    pkwt.no.should == no
  end
  
  it "should not allow object creation without office id" do
    no = "1234567890"
    pkwt = Pkwt.create_object( 
        :office_id => "",
        :no => no,
        :is_employee => true,
        :employee_id => @employee.id,
        :length_of_contract => 3,
        :start_date => DateTime.new(2015,01,01),
        :end_date => DateTime.new(2015,03,30)
      )
      
    pkwt.should_not be_valid
  end
  
  it "should not allow object creation with invalid office id" do
    no = "1234567890"
    pkwt = Pkwt.create_object( 
        :office_id => 0,
        :no => no,
        :is_employee => true,
        :employee_id => @employee.id,
        :length_of_contract => 3,
        :start_date => DateTime.new(2015,01,01),
        :end_date => DateTime.new(2015,03,30)
      )
      
    pkwt.should_not be_valid
  end
  
  it "should not allow object creation without no" do
    no = "1234567890"
    pkwt = Pkwt.create_object( 
        :office_id => @office.id,
        :no => "",
        :is_employee => true,
        :employee_id => @employee.id,
        :length_of_contract => 3,
        :start_date => DateTime.new(2015,01,01),
        :end_date => DateTime.new(2015,03,30)
      )
      
    pkwt.should_not be_valid
  end
  
  it "should not allow object creation without length_of_contract" do
    no = "1234567890"
    pkwt = Pkwt.create_object( 
        :office_id => @office.id,
        :no => no,
        :is_employee => true,
        :employee_id => @employee.id,
        :length_of_contract => "",
        :start_date => DateTime.new(2015,01,01),
        :end_date => DateTime.new(2015,03,30)
      )
      
    pkwt.should_not be_valid
  end
  
  it "should not allow object creation with zero length_of_contract" do
    no = "1234567890"
    pkwt = Pkwt.create_object( 
        :office_id => @office.id,
        :no => no,
        :is_employee => true,
        :employee_id => @employee.id,
        :length_of_contract => 0,
        :start_date => DateTime.new(2015,01,01),
        :end_date => DateTime.new(2015,03,30)
      )
      
    pkwt.should_not be_valid
  end
  
  it "should not allow object creation without start date" do
    no = "1234567890"
    pkwt = Pkwt.create_object( 
        :office_id => @office.id,
        :no => no,
        :is_employee => true,
        :employee_id => @employee.id,
        :length_of_contract => 3,
        :start_date => "",
        :end_date => DateTime.new(2015,03,30)
      )
      
    pkwt.should_not be_valid
  end
  
  it "should not allow object creation without end date" do
    no = "1234567890"
    pkwt = Pkwt.create_object( 
        :office_id => @office.id,
        :no => no,
        :is_employee => true,
        :employee_id => @employee.id,
        :length_of_contract => 3,
        :start_date => DateTime.new(2015,01,01),
        :end_date => ""
      )
      
    pkwt.should_not be_valid
  end
  
  it "should not allow object creation with duplicate no" do
    no = "1234567890"
    pkwt = Pkwt.create_object(
        :office_id => @office.id,
        :no => no,
        :is_employee => true,
        :employee_id => @employee.id,
        :length_of_contract => 3,
        :start_date => DateTime.new(2015,01,01),
        :end_date => DateTime.new(2015,03,30)
      )
      
    pkwt.should be_valid
    
    pkwt_2 = Pkwt.create_object(
        :office_id => @office.id,
        :no => no,
        :is_employee => true,
        :employee_id => @employee.id,
        :length_of_contract => 3,
        :start_date => DateTime.new(2015,01,01),
        :end_date => DateTime.new(2015,03,30)
      )
      
    pkwt_2.should_not be_valid
  end
  
  context "jika pkwt sudah ada" do
      before (:each) do
          @pkwt_1_no = "1234567890"
          @pkwt = Pkwt.create_object(
              :office_id => @office.id,
              :no => @pkwt_1_no,
              :is_employee => true,
              :employee_id => @employee.id,
              :length_of_contract => 3,
              :start_date => DateTime.new(2015,01,01),
              :end_date => DateTime.new(2015,03,30)
              )
          
          @pkwt_2_no = "0987654321"
          @pkwt_2 = Pkwt.create_object(
              :office_id => @office.id,
              :no => @pkwt_2_no,
              :is_employee => true,
              :employee_id => @employee.id,
              :length_of_contract => 3,
              :start_date => DateTime.new(2015,02,01),
              :end_date => DateTime.new(2015,04,30)
              )
      end
      
      it "should update pkwt with no" do
            @pkwt.update_object(
                  :office_id => @office.id,
                  :no => @pkwt_1_no,
                  :is_employee => false,
                  :employee_id => @recruitment.id,
                  :length_of_contract => 3,
                  :start_date => DateTime.new(2015,02,01),
                  :end_date => DateTime.new(2015,04,30)
                )
              
            @pkwt.should be_valid
              
            @pkwt.reload
              
            @pkwt.no.should == @pkwt_1_no
      end
      
      it "should not duplicate no" do
          @pkwt_2.update_object(
                  :office_id => @office.id,
                  :no => @pkwt_1_no,
                  :is_employee => false,
                  :employee_id => @recruitment.id,
                  :length_of_contract => 3,
                  :start_date => DateTime.new(2015,02,01),
                  :end_date => DateTime.new(2015,04,30)
                )
         
          @pkwt_2.should_not be_valid
      end
      
      context "deleted one pkwt" do
          before(:each) do
              @pkwt.delete_object
              @pkwt.should be_valid
          end
          
          it "should have deleted pkwt" do
              @pkwt.is_deleted.should be_truthy
          end
          
          it "should be allowed to create another pkwt with same data" do
             @pkwt_2 = Pkwt.create_object(
                  :office_id => @office.id,
                  :no => @pkwt_1_no,
                  :is_employee => false,
                  :employee_id => @recruitment.id,
                  :length_of_contract => 3,
                  :start_date => DateTime.new(2015,02,01),
                  :end_date => DateTime.new(2015,04,30)
                )
          
             @pkwt_2.should be_valid
          end
          
      end
  end
end
