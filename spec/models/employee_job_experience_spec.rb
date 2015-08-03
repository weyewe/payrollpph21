require 'rails_helper'

RSpec.describe EmployeeJobExperience, type: :model do
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
  
  it "should allow object creation with code and name" do
    employee_job_experience = EmployeeJobExperience.create_object(
        :employee_id => @employee.id,
        :company_name => "PT. Mitra Sentosa",
        :range_year => "2007 - 2008"
      )
      
    employee_job_experience.should be_valid
    
    employee_job_experience.company_name.should == "PT. Mitra Sentosa"
    employee_job_experience.range_year.should == "2007 - 2008"
  end
  
  it "should not allow object creation without employee id" do
    employee_job_experience = EmployeeJobExperience.create_object( 
        :employee_id => "",
        :company_name => "PT. Mitra Sentosa",
        :range_year => "2007 - 2008"
      )
      
    employee_job_experience.should_not be_valid
  end
  
  it "should not allow object creation with invalid employee id" do
    employee_job_experience = EmployeeJobExperience.create_object( 
        :employee_id => 0,
        :company_name => "PT. Mitra Sentosa",
        :range_year => "2007 - 2008"
      )
      
    employee_job_experience.should_not be_valid
  end
  
  it "should not allow object creation without company name" do
    employee_job_experience = EmployeeJobExperience.create_object( 
        :employee_id => @employee.id,
        :company_name => "",
        :range_year => "2007 - 2008"
      )
      
    employee_job_experience.should_not be_valid
  end
  
  it "should not allow object creation without range year" do
    employee_job_experience = EmployeeJobExperience.create_object( 
        :employee_id => @employee.id,
        :company_name => "PT. Mitra Sentosa",
        :range_year => ""
      )
      
    employee_job_experience.should_not be_valid
  end
  
  context "has been created employee_job_experience" do
    before(:each) do
      @employee_job_experience_1_company_name = "PT. Mitra Sentosa"
      @employee_job_experience_1_range_year = "2007 - 2008"
      @employee_job_experience = EmployeeJobExperience.create_object(
          :employee_id => @employee.id,
          :company_name => @employee_job_experience_1_company_name,
          :range_year => @employee_job_experience_1_range_year
        )
        
      @employee_job_experience_2_company_name = "PT. Abadi Jaya"
      @employee_job_experience_2_range_year = "2008 - 2009"
      @employee_job_experience_2 = EmployeeJobExperience.create_object(
          :employee_id => @employee.id,
          :company_name => @employee_job_experience_2_company_name,
          :range_year => @employee_job_experience_2_range_year
        )
    end
    
    it "should have 2 objects" do
      EmployeeJobExperience.count.should == 2 
    end
    
    it "should create valid objects" do
      @employee_job_experience.should be_valid
      @employee_job_experience_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_company_name = "PT. Berkah Abadi"
      new_range_year = "2010 - 2014"
      
      @employee_job_experience.update_object(
          :employee_id => @employee.id,
          :company_name => new_company_name,
          :range_year => new_range_year
        )
        
      @employee_job_experience.should be_valid
      
      @employee_job_experience.reload 
      
      @employee_job_experience.company_name.should == new_company_name
      @employee_job_experience.range_year.should == new_range_year
    end
    
    it "should be allowed to delete object 2" do
      @employee_job_experience_2.delete_object
      
      @employee_job_experience_2.persisted?.should be_falsy  # be_truthy 
      
      EmployeeJobExperience.count.should == 1 
    end
  end
end
