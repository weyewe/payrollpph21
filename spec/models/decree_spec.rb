require 'rails_helper'

RSpec.describe Decree, type: :model do
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
          
      @branch_office_2 = BranchOffice.create_object(
            :office_id => @office.id,
            :code => "SSDJKT",
            :name => "Solusi Sentral Data - Jakarta"
          )
          
      @department_2 = Department.create_object(
            :office_id => @office.id,
            :branch_office_id => @branch_office_2.id,
            :code => "IT",
            :name => "IT"
          )
     
      @division_2 = Division.create_object(
            :office_id => @office.id,
            :branch_office_id => @branch_office_2.id,
            :department_id => @department_2.id,
            :code => "007",
            :name => "Programmer"
          )
      
      @title_2 = Title.create_object(
            :office_id => @office.id,
            :code => "S007",
            :name => "Senior Programmer"
          )
  end
  
  it "should allow object creation with all requirement field" do
    no = "SK/2015/XX/YY"
    decree = Decree.create_object(
        :no => no,
        :date => DateTime.new(2015,01,01),
        :employee_id => @employee.id,
        :office_id => @office.id,
        :branch_office_id => @branch_office_2.id,
        :department_id => @department_2.id,
        :division_id => @division_2.id,
        :title_id => @title_2.id,
        :sk_type => SK_TYPE[:promosi]
      )
      
    decree.should be_valid
    
    decree.no.should == no
  end
  
  it "should allow object creation without date" do
    no = "SK/2015/XX/YY"
    decree = Decree.create_object(
        :no => no,
        :date => "",
        :employee_id => @employee.id,
        :office_id => @office.id,
        :branch_office_id => @branch_office_2.id,
        :department_id => @department_2.id,
        :division_id => @division_2.id,
        :title_id => @title_2.id,
        :sk_type => SK_TYPE[:promosi]
      )
      
    decree.should_not be_valid
  end
  
  it "should allow object creation without employee id" do
    no = "SK/2015/XX/YY"
    decree = Decree.create_object(
        :no => no,
        :date => DateTime.new(2015,01,01),
        :employee_id => "",
        :office_id => @office.id,
        :branch_office_id => @branch_office_2.id,
        :department_id => @department_2.id,
        :division_id => @division_2.id,
        :title_id => @title_2.id,
        :sk_type => SK_TYPE[:promosi]
      )
      
    decree.should_not be_valid
  end
  
  it "should allow object creation with invalid employee id" do
    no = "SK/2015/XX/YY"
    decree = Decree.create_object(
        :no => no,
        :date => DateTime.new(2015,01,01),
        :employee_id => 0,
        :office_id => @office.id,
        :branch_office_id => @branch_office_2.id,
        :department_id => @department_2.id,
        :division_id => @division_2.id,
        :title_id => @title_2.id,
        :sk_type => SK_TYPE[:promosi]
      )
      
    decree.should_not be_valid
  end
  
  it "should allow object creation without office id" do
    no = "SK/2015/XX/YY"
    decree = Decree.create_object(
        :no => no,
        :date => DateTime.new(2015,01,01),
        :employee_id => @employee.id,
        :office_id => "",
        :branch_office_id => @branch_office_2.id,
        :department_id => @department_2.id,
        :division_id => @division_2.id,
        :title_id => @title_2.id,
        :sk_type => SK_TYPE[:promosi]
      )
      
    decree.should_not be_valid
  end
  
  it "should allow object creation with invalid office id" do
    no = "SK/2015/XX/YY"
    decree = Decree.create_object(
        :no => no,
        :date => DateTime.new(2015,01,01),
        :employee_id => @employee.id,
        :office_id => 0,
        :branch_office_id => @branch_office_2.id,
        :department_id => @department_2.id,
        :division_id => @division_2.id,
        :title_id => @title_2.id,
        :sk_type => SK_TYPE[:promosi]
      )
      
    decree.should_not be_valid
  end
  
  it "should allow object creation without branch office id" do
    no = "SK/2015/XX/YY"
    decree = Decree.create_object(
        :no => no,
        :date => DateTime.new(2015,01,01),
        :employee_id => @employee.id,
        :office_id => @office.id,
        :branch_office_id => "",
        :department_id => @department_2.id,
        :division_id => @division_2.id,
        :title_id => @title_2.id,
        :sk_type => SK_TYPE[:promosi]
      )
      
    decree.should_not be_valid
  end
  
  it "should allow object creation with invalid branch office id" do
    no = "SK/2015/XX/YY"
    decree = Decree.create_object(
        :no => no,
        :date => DateTime.new(2015,01,01),
        :employee_id => @employee.id,
        :office_id => @office.id,
        :branch_office_id => 0,
        :department_id => @department_2.id,
        :division_id => @division_2.id,
        :title_id => @title_2.id,
        :sk_type => SK_TYPE[:promosi]
      )
      
    decree.should_not be_valid
  end
  
  it "should allow object creation without department id" do
    no = "SK/2015/XX/YY"
    decree = Decree.create_object(
        :no => no,
        :date => DateTime.new(2015,01,01),
        :employee_id => @employee.id,
        :office_id => @office.id,
        :branch_office_id => @branch_office_2.id,
        :department_id => "",
        :division_id => @division_2.id,
        :title_id => @title_2.id,
        :sk_type => SK_TYPE[:promosi]
      )
      
    decree.should_not be_valid
  end
  
  it "should allow object creation with invalid department id" do
    no = "SK/2015/XX/YY"
    decree = Decree.create_object(
        :no => no,
        :date => DateTime.new(2015,01,01),
        :employee_id => @employee.id,
        :office_id => @office.id,
        :branch_office_id => @branch_office_2.id,
        :department_id => 0,
        :division_id => @division_2.id,
        :title_id => @title_2.id,
        :sk_type => SK_TYPE[:promosi]
      )
      
    decree.should_not be_valid
  end
  
  it "should allow object creation without division id" do
    no = "SK/2015/XX/YY"
    decree = Decree.create_object(
        :no => no,
        :date => DateTime.new(2015,01,01),
        :employee_id => @employee.id,
        :office_id => @office.id,
        :branch_office_id => @branch_office_2.id,
        :department_id => @department_2.id,
        :division_id => "",
        :title_id => @title_2.id,
        :sk_type => SK_TYPE[:promosi]
      )
      
    decree.should_not be_valid
  end
  
  it "should allow object creation with invalid division id" do
    no = "SK/2015/XX/YY"
    decree = Decree.create_object(
        :no => no,
        :date => DateTime.new(2015,01,01),
        :employee_id => @employee.id,
        :office_id => @office.id,
        :branch_office_id => @branch_office_2.id,
        :department_id => @department_2.id,
        :division_id => 0,
        :title_id => @title_2.id,
        :sk_type => SK_TYPE[:promosi]
      )
      
    decree.should_not be_valid
  end
  
  it "should allow object creation without title id" do
    no = "SK/2015/XX/YY"
    decree = Decree.create_object(
        :no => no,
        :date => DateTime.new(2015,01,01),
        :employee_id => @employee.id,
        :office_id => @office.id,
        :branch_office_id => @branch_office_2.id,
        :department_id => @department_2.id,
        :division_id => @division_2.id,
        :title_id => "",
        :sk_type => SK_TYPE[:promosi]
      )
      
    decree.should_not be_valid
  end
  
  it "should allow object creation with invalid title id" do
    no = "SK/2015/XX/YY"
    decree = Decree.create_object(
        :no => no,
        :date => DateTime.new(2015,01,01),
        :employee_id => @employee.id,
        :office_id => @office.id,
        :branch_office_id => @branch_office_2.id,
        :department_id => @department_2.id,
        :division_id => @division_2.id,
        :title_id => 0,
        :sk_type => SK_TYPE[:promosi]
      )
      
    decree.should_not be_valid
  end
  
  it "should allow object creation without sk type" do
    no = "SK/2015/XX/YY"
    decree = Decree.create_object(
        :no => no,
        :date => DateTime.new(2015,01,01),
        :employee_id => @employee.id,
        :office_id => @office.id,
        :branch_office_id => @branch_office_2.id,
        :department_id => @department_2.id,
        :division_id => @division_2.id,
        :title_id => @title_2.id,
        :sk_type => ""
      )
      
    decree.should_not be_valid
  end
  
  it "should not allow object creation with duplicate code" do
    no = "SK/2015/XX/YY"
    decree = Decree.create_object(
        :no => no,
        :date => DateTime.new(2015,01,01),
        :employee_id => @employee.id,
        :office_id => @office.id,
        :branch_office_id => @branch_office_2.id,
        :department_id => @department_2.id,
        :division_id => @division_2.id,
        :title_id => @title_2.id,
        :sk_type => SK_TYPE[:promosi]
      )
      
    decree.should be_valid
    
    decree_2 = Decree.create_object(
        :no => no,
        :date => DateTime.new(2015,01,01),
        :employee_id => @employee.id,
        :office_id => @office.id,
        :branch_office_id => @branch_office_2.id,
        :department_id => @department_2.id,
        :division_id => @division_2.id,
        :title_id => @title_2.id,
        :sk_type => SK_TYPE[:promosi]
      )
      
    decree_2.should_not be_valid
  end
  
  context "has been created employee" do
    before(:each) do
      @decree_1_no = "2015/06/XX/YY"
      @decree = Decree.create_object(
        :no => @decree_1_no,
        :date => DateTime.new(2015,01,01),
        :employee_id => @employee.id,
        :office_id => @office.id,
        :branch_office_id => @branch_office_2.id,
        :department_id => @department_2.id,
        :division_id => @division_2.id,
        :title_id => @title_2.id,
        :sk_type => SK_TYPE[:promosi]
      )
        
      @decree_2_no = "2015/07/AA/BB"
      @decree_2 = Decree.create_object(
        :no => @decree_2_no,
        :date => DateTime.new(2015,01,01),
        :employee_id => @employee.id,
        :office_id => @office.id,
        :branch_office_id => @branch_office_2.id,
        :department_id => @department_2.id,
        :division_id => @division_2.id,
        :title_id => @title_2.id,
        :sk_type => SK_TYPE[:penetapan]
      )
    end
    
    it "should have 2 objects" do
      Decree.count.should == 2 
    end
    
    it "should create valid objects" do
      @decree.should be_valid
      @decree_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_no = "2015/08/MM/NN"
      
      @decree.update_object(
          :no => new_no,
          :date => DateTime.new(2015,01,01),
          :employee_id => @employee.id,
          :office_id => @office.id,
          :branch_office_id => @branch_office_2.id,
          :department_id => @department_2.id,
          :division_id => @division_2.id,
          :title_id => @title_2.id,
          :sk_type => SK_TYPE[:promosi]
        )
        
      @decree.should be_valid
      
      @decree.reload 
      
      @decree.no.should == new_no
    end
    
    it "should not allow duplicate code" do
      @decree_2.update_object(
          :no => @degree_1_no,
          :date => DateTime.new(2015,01,01),
          :employee_id => @employee.id,
          :office_id => @office.id,
          :branch_office_id => @branch_office_2.id,
          :department_id => @department_2.id,
          :division_id => @division_2.id,
          :title_id => @title_2.id,
          :sk_type => SK_TYPE[:promosi]
        )
        
      @decree_2.errors.size.should_not == 0 
      @decree_2.should_not be_valid
    end
    
    context "deleted one shift allocation" do
        before(:each) do
            @decree.delete_object
            @decree.should be_valid
        end
        
        it "should have deleted shift allocation" do
            @decree.is_deleted.should be_truthy
        end
        
        it "should be allowed to create another decree with same data" do
            @decree_2 = Decree.create_object(
                :no => @decree_1_no,
                :date => DateTime.new(2015,01,01),
                :employee_id => @employee.id,
                :office_id => @office.id,
                :branch_office_id => @branch_office_2.id,
                :department_id => @department_2.id,
                :division_id => @division_2.id,
                :title_id => @title_2.id,
                :sk_type => SK_TYPE[:penetapan]
              )
        
            @decree_2.should be_valid
        end
    end
  end
end
