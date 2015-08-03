require 'rails_helper'

RSpec.describe WageTaxation, type: :model do
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
      
      @tax_code = TaxCode.create_object(
            :office_id => @office.id,
            :code => "21-100-01",
            :name => "Pegawai Tetap"
          )
  end
  
  it "should allow object creation with all field required" do
    effective_date = Date.new(2015,01,01)
    wage_taxation = WageTaxation.create_object(
        :employee_id => @employee.id,
        :effective_date => effective_date,
        :tax_code_id => @tax_code.id,
        :marital_status => MARITAL_STATUS[:single],
        :number_of_children => 0,
        :tax_method => TAX_METHOD[:netto]
      )
      
    wage_taxation.should be_valid
    
    wage_taxation.effective_date.should == effective_date
  end
  
  it "should not allow object creation without employee id" do
   effective_date = Date.new(2015,01,01)
    wage_taxation = WageTaxation.create_object(
        :employee_id => "",
        :effective_date => effective_date,
        :tax_code_id => @tax_code.id,
        :marital_status => MARITAL_STATUS[:single],
        :number_of_children => 0,
        :tax_method => TAX_METHOD[:netto]
      )
      
    wage_taxation.should_not be_valid
  end
  
  it "should not allow object creation with invalid employee id" do
    effective_date = Date.new(2015,01,01)
    wage_taxation = WageTaxation.create_object(
        :employee_id => 0,
        :effective_date => effective_date,
        :tax_code_id => @tax_code.id,
        :marital_status => MARITAL_STATUS[:single],
        :number_of_children => 0,
        :tax_method => TAX_METHOD[:netto]
      )
      
    wage_taxation.should_not be_valid
  end
  
  it "should not allow object creation without effective date" do
    effective_date = Date.new(2015,01,01)
    wage_taxation = WageTaxation.create_object(
        :employee_id => @employee.id,
        :effective_date => "",
        :tax_code_id => @tax_code.id,
        :marital_status => MARITAL_STATUS[:single],
        :number_of_children => 0,
        :tax_method => TAX_METHOD[:netto]
      )
      
    wage_taxation.should_not be_valid
  end
  
  it "should not allow object creation without tax code id" do
   effective_date = Date.new(2015,01,01)
    wage_taxation = WageTaxation.create_object(
        :employee_id => @employee.id,
        :effective_date => effective_date,
        :tax_code_id => "",
        :marital_status => MARITAL_STATUS[:single],
        :number_of_children => 0,
        :tax_method => TAX_METHOD[:netto]
      )
      
    wage_taxation.should_not be_valid
  end
  
  it "should not allow object creation with invalid tx code id" do
    effective_date = Date.new(2015,01,01)
    wage_taxation = WageTaxation.create_object(
        :employee_id => @employee.id,
        :effective_date => effective_date,
        :tax_code_id => 0,
        :marital_status => MARITAL_STATUS[:single],
        :number_of_children => 0,
        :tax_method => TAX_METHOD[:netto]
      )
      
    wage_taxation.should_not be_valid
  end
  
  it "should not allow object creation without marital_status" do
   effective_date = Date.new(2015,01,01)
    wage_taxation = WageTaxation.create_object(
        :employee_id => @employee.id,
        :effective_date => effective_date,
        :tax_code_id => @tax_code.id,
        :marital_status => "",
        :number_of_children => 0,
        :tax_method => TAX_METHOD[:netto]
      )
      
    wage_taxation.should_not be_valid
  end
  
  it "should not allow object creation without number of children" do
   effective_date = Date.new(2015,01,01)
    wage_taxation = WageTaxation.create_object(
        :employee_id => @employee.id,
        :effective_date => effective_date,
        :tax_code_id => @tax_code.id,
        :marital_status => MARITAL_STATUS[:single],
        :number_of_children => "",
        :tax_method => TAX_METHOD[:netto]
      )
      
    wage_taxation.should_not be_valid
  end
  
  it "should not allow object creation with without tax method" do
    effective_date = Date.new(2015,01,01)
    wage_taxation = WageTaxation.create_object(
        :employee_id => @employee.id,
        :effective_date => effective_date,
        :tax_code_id => @tax_code.id,
        :marital_status => MARITAL_STATUS[:single],
        :number_of_children => 0,
        :tax_method => ""
      )
      
    wage_taxation.should_not be_valid
  end
  
  context "has been created wage_taxation" do
    before(:each) do
      @wage_1_effective_date = Date.new(2015,01,01)
      @wage_taxation = WageTaxation.create_object(
          :employee_id => @employee.id,
          :effective_date => @wage_1_effective_date,
          :tax_code_id => @tax_code.id,
          :marital_status => MARITAL_STATUS[:single],
          :number_of_children => 0,
          :tax_method => TAX_METHOD[:netto]
        )
        
      @wage_2_effective_date = Date.new(2015,02,01)
      @wage_2 = WageTaxation.create_object(
          :employee_id => @employee.id,
          :effective_date => @wage_2_effective_date,
          :tax_code_id => @tax_code.id,
          :marital_status => MARITAL_STATUS[:married],
          :number_of_children => 1,
          :tax_method => TAX_METHOD[:netto]
        )
    end
    
    it "should have 2 objects" do
      WageTaxation.count.should == 2 
    end
    
    it "should create valid objects" do
      @wage_taxation.should be_valid
      @wage_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_effective_date = Date.new(2015,04,01)
      @wage_taxation.update_object(
          :employee_id => @employee.id,
          :effective_date => new_effective_date,
          :tax_code_id => @tax_code.id,
          :marital_status => MARITAL_STATUS[:single],
          :number_of_children => 0,
          :tax_method => TAX_METHOD[:netto]
        )
        
      @wage_taxation.should be_valid
      
      @wage_taxation.reload 
      
      @wage_taxation.effective_date.should == new_effective_date
    end
    
    it "should be allowed to delete object because it last salary" do
      @wage_2.delete_object
      
      @wage_2.persisted?.should be_falsy  # be_truthy 
      
      WageTaxation.count.should == 1 
    end
    
    it "should not be allowed to delete object because not last salary" do
      @wage_taxation.delete_object
      
      @wage_taxation.persisted?.should be_truthy  # be_truthy 
      
      WageTaxation.count.should == 2
    end
  end
end
