require 'rails_helper'

RSpec.describe BpjsInsurance, type: :model do
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
  end
  
  it "should allow object creation with all required field" do
    no = "JK102910"
    bpjs_insurance = BpjsInsurance.create_object(
        :employee_id => @employee.id,
        :date => DateTime.new(2015,2,8),
        :no => no,
        :premi => 1250000
      )
      
    bpjs_insurance.should be_valid
  end
  
  it "should not allow object creation without employee id" do
    no = "JK102910"
    bpjs_insurance = BpjsInsurance.create_object(
        :employee_id => "",
        :date => DateTime.new(2015,2,8),
        :no => no,
        :premi => 1250000
      )
      
    bpjs_insurance.should_not be_valid
  end
  
  it "should not allow object creation with invalid employee id" do
    no = "JK102910"
    bpjs_insurance = BpjsInsurance.create_object(
        :employee_id => 0,
        :date => DateTime.new(2015,2,8),
        :no => no,
        :premi => 1250000
      )
      
    bpjs_insurance.should_not be_valid
  end
  
  it "should not allow object creation without date" do
    no = "JK102910"
    bpjs_insurance = BpjsInsurance.create_object(
        :employee_id => "",
        :date => "",
        :no => no,
        :premi => 1250000
      )
      
    bpjs_insurance.should_not be_valid
  end
  
  it "should allow object creation without no" do
    no = "JK102910"
    bpjs_insurance = BpjsInsurance.create_object(
        :employee_id => "",
        :date => DateTime.new(2015,2,8),
        :no => "",
        :premi => 1250000
      )
      
    bpjs_insurance.should_not be_valid
  end
  
  it "should allow object creation without premi" do
    no = "JK102910"
    bpjs_insurance = BpjsInsurance.create_object(
        :employee_id => "",
        :date => DateTime.new(2015,2,8),
        :no => no,
        :premi => ""
      )
      
    bpjs_insurance.should_not be_valid
  end
  
  it "should allow object creation with invalid premi" do
    no = "JK102910"
    bpjs_insurance = BpjsInsurance.create_object(
        :employee_id => "",
        :date => DateTime.new(2015,2,8),
        :no => no,
        :premi => 0
      )
      
    bpjs_insurance.should_not be_valid
  end
  
  it "should not allow object creation with duplicate date" do
    no = "JK102910"
    bpjs_insurance = BpjsInsurance.create_object(
        :employee_id => @employee.id,
        :date => DateTime.new(2015,2,8),
        :no => no,
        :premi => 1250000
      )
      
    bpjs_insurance.should be_valid
    
    bpjs_insurance_2 = BpjsInsurance.create_object( 
        :employee_id => @employee.id,
        :date => DateTime.new(2015,2,8),
        :no => no,
        :premi => 1250000
      )
      
    bpjs_insurance_2.should_not be_valid
  end
  
  context "has been created bpjs_insurance" do
    before(:each) do
      no = "JK102910"
      @bpjs_insurance = BpjsInsurance.create_object(
          :employee_id => @employee.id,
          :date => DateTime.new(2015,2,8),
          :no => no,
          :premi => 1250000
        )
        
      @bpjs_insurance_2 = BpjsInsurance.create_object(
          :employee_id => @employee.id,
          :date => DateTime.new(2015,3,8),
          :no => no,
          :premi => 2250000
        )
    end
    
    it "should have 2 objects" do
      BpjsInsurance.count.should == 2 
    end
    
    it "should create valid objects" do
      @bpjs_insurance.should be_valid
      @bpjs_insurance_2.should be_valid
    end
    
    it "should be allowed to update" do
      @bpjs_insurance.update_object(
          :employee_id => @employee.id,
          :date => DateTime.new(2015,4,8),
          :no => "JK182828",
          :premi => 2250000
        )
        
      @bpjs_insurance.should be_valid
      
      @bpjs_insurance.reload 
    end
    
    it "should be allowed to delete object 2" do
      @bpjs_insurance_2.delete_object
      
      @bpjs_insurance_2.should be_valid
    end
    
    context "has been deleted bpjs_insurance" do
        before(:each) do
            @bpjs_insurance_2.delete_object
        end
        
        it "should delete valid object" do
            @bpjs_insurance_2.should be_valid
        end
        
        it "should be allowed to create object 3" do
          @bpjs_insurance_3 = BpjsInsurance.create_object(
              :employee_id => @employee.id,
              :date => DateTime.new(2015,3,8),
              :no => "JK182828",
              :premi => 2250000
            )
          
          @bpjs_insurance_3.should be_valid
        end
    end
  end
end
