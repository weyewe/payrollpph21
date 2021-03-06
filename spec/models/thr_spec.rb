require 'rails_helper'

RSpec.describe Thr, type: :model do
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
    thr = Thr.create_object(
        :employee_id => @employee.id,
        :date => DateTime.new(2015,2,8),
        :value => 1250000
      )
      
    thr.should be_valid
    
    thr.date.should == DateTime.new(2015,2,8)
    thr.value.should == 1250000
  end
  
  it "should not allow object creation without employee id" do
    thr = Thr.create_object( 
        :employee_id => "",
        :date => DateTime.new(2015,2,8),
        :value => 1250000
      )
      
    thr.should_not be_valid
  end
  
  it "should not allow object creation with invalid employee id" do
    thr = Thr.create_object( 
        :employee_id => 0,
        :date => DateTime.new(2015,2,8),
        :value => 1250000
      )
      
    thr.should_not be_valid
  end
  
  it "should not allow object creation without date" do
    thr = Thr.create_object( 
        :employee_id => @employee.id,
        :date => "",
        :value => 1250000
      )
      
    thr.should_not be_valid
  end
  
  it "should allow object creation without value" do
    thr = Thr.create_object(
        :employee_id => @employee.id,
        :date => DateTime.new(2015,2,8),
        :value => ""
      )
      
    thr.should_not be_valid
  end
  
  context "has been created thr" do
    before(:each) do
      @thr = Thr.create_object(
          :employee_id => @employee.id,
          :date => DateTime.new(2015,2,8),
          :value => 1250000
        )
        
      @thr_2 = Thr.create_object(
          :employee_id => @employee.id,
          :date => DateTime.new(2015,3,8),
          :value => 1250000
        )
    end
    
    it "should have 2 objects" do
      Thr.count.should == 2 
    end
    
    it "should create valid objects" do
      @thr.should be_valid
      @thr_2.should be_valid
    end
    
    it "should be allowed to update" do
      @thr.update_object(
          :employee_id => @employee.id,
          :date => DateTime.new(2015,2,8),
          :value => 1350000
        )
        
      @thr.should be_valid
      
      @thr.reload 
      
      @thr.date.should == DateTime.new(2015,2,8)
      @thr.value.should == 1350000
    end
    
    it "should be allowed to delete object 2" do
      @thr_2.delete_object
      
      @thr_2.should be_valid
      
      @thr_2.is_deleted.should be_truthy
    end
    
    context "has been deleted thr" do
        before(:each) do
            @thr_2.delete_object
        end
        
        it "should delete valid object" do
            @thr_2.should be_valid
        end
        
        it "should be allowed to create object 3" do
          @thr_3 = Thr.create_object(
              :employee_id => @employee.id,
              :date => DateTime.new(2015,3,8),
              :value => 1250000
            )
          
          @thr_3.should be_valid
          
          @thr_3.date.should == DateTime.new(2015,3,8)
          @thr_3.value.should == 1250000
        end
    end
    
  end
end
