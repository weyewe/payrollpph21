require 'rails_helper'

RSpec.describe Certificate, type: :model do
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
    certificate = Certificate.create_object(
        :employee_id => @employee.id,
        :no_certificate => "XX-YYYY-HHHH",
        :received_at => DateTime.new(2015,2,18),
        :receiver => "Pebri"
      )
      
    certificate.should be_valid
    
    certificate.no_certificate.should == "XX-YYYY-HHHH"
    certificate.receiver.should == "Pebri"
  end
  
  it "should not allow object creation without employee id" do
    certificate = Certificate.create_object( 
        :employee_id => "",
        :no_certificate => "XX-YYYY-HHHH",
        :received_at => DateTime.new(2015,2,18),
        :receiver => "Pebri"
      )
      
    certificate.should_not be_valid
  end
  
  it "should not allow object creation with invalid employee id" do
    certificate = Certificate.create_object( 
        :employee_id => 0,
        :no_certificate => "XX-YYYY-HHHH",
        :received_at => DateTime.new(2015,2,18),
        :receiver => "Pebri"
      )
      
    certificate.should_not be_valid
  end
  
  it "should not allow object creation without no certificate" do
    certificate = Certificate.create_object( 
        :employee_id => @employee.id,
        :no_certificate => "",
        :received_at => DateTime.new(2015,2,18),
        :receiver => "Pebri"
      )
      
    certificate.should_not be_valid
  end
  
  it "should not allow object creation without received date" do
    certificate = Certificate.create_object( 
        :employee_id => @employee.id,
        :no_certificate => "XX-YYYY-HHHH",
        :received_at => "",
        :receiver => "Pebri"
      )
      
    certificate.should_not be_valid
  end
  
  it "should not allow object creation without receiver" do
    certificate = Certificate.create_object( 
        :employee_id => @employee.id,
        :no_certificate => "XX-YYYY-HHHH",
        :received_at => DateTime.new(2015,2,18),
        :receiver => ""
      )
      
    certificate.should_not be_valid
  end
  
  context "has been created certificate" do
    before(:each) do
      @certificate = Certificate.create_object(
          :employee_id => @employee.id,
          :no_certificate => "XX-YYYY-HHHH",
          :received_at => DateTime.new(2015,2,18),
          :receiver => "Pebri"
        )
        
      @certificate_2 = Certificate.create_object(
          :employee_id => @employee.id,
          :no_certificate => "MM-NN-HHHH",
          :received_at => DateTime.new(2015,1,18),
          :receiver => "Bambang"
        )
    end
    
    it "should have 2 objects" do
      Certificate.count.should == 2 
    end
    
    it "should create valid objects" do
      @certificate.should be_valid
      @certificate_2.should be_valid
    end
    
    it "should be allowed to update" do
      @certificate.update_object(
          :employee_id => @employee.id,
          :no_certificate => "XX-YYYY-HHHH",
          :received_at => DateTime.new(2015,2,18),
          :receiver => "Pebri"
        )
        
      @certificate.should be_valid
      
      @certificate.reload 
      
      @certificate.no_certificate.should == "XX-YYYY-HHHH"
      @certificate.received_at.should == DateTime.new(2015,2,18)
      @certificate.receiver.should == "Pebri"
    end
    
    it "should be allowed to delete object 2" do
      @certificate_2.delete_object
      
      @certificate_2.should be_valid
      
      @certificate_2.is_deleted.should == true
    end
    
    it "should be allowed to returned certificate object 2" do
      @certificate_2.returned_certificate(
            :returned_at => DateTime.new(2015,9,10),
            :giver => "Andris",
            :description => "Sudah kembali"
          )
      
      @certificate_2.should be_valid
      
      @certificate_2.is_returned.should == true
      @certificate_2.returned_at.should == DateTime.new(2015,9,10)
      @certificate_2.giver.should == "Andris"
    end
  end
end
