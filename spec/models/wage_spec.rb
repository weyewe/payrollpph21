require 'rails_helper'

RSpec.describe Wage, type: :model do
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
      
      @pph21 = Pph21.create_object(
            :office_id => @office.id,
            :code => "PPH212013",
            :name => "PPh21 Aturan Tahun 2013"
          )
      
      @ptkp = Ptkp.create_object(
            :office_id => @office.id,
            :code => "PTKP2013",
            :name => "PTKP Aturan Tahun 2013"
          )
      
      @jamsostek = Jamsostek.create_object(
            :office_id => @office.id,
            :code => "JSTK2013",
            :name => "Jamsostek Aturan Tahun 2013",
            :jkk_percentage => 0.24,
            :jkm_percentage => 0.3,
            :jht_employee_percentage => 2,
            :jht_office_percentage => 3.7
          )
  end
  
  it "should allow object creation with all field required" do
    effective_date = Date.new(2015,01,01)
    wage = Wage.create_object(
        :employee_id => @employee.id,
        :effective_date => effective_date,
        :pph21_id => @pph21.id,
        :ptkp_id => @ptkp.id,
        :jamsostek_id => @jamsostek.id
      )
      
    wage.should be_valid
    
    wage.effective_date.should == effective_date
  end
  
  it "should not allow object creation without employee id" do
   effective_date = Date.new(2015,01,01)
    wage = Wage.create_object(
        :employee_id => "",
        :effective_date => effective_date,
        :pph21_id => @pph21.id,
        :ptkp_id => @ptkp.id,
        :jamsostek_id => @jamsostek.id
      )
      
    wage.should_not be_valid
  end
  
  it "should not allow object creation with invalid employee id" do
    effective_date = Date.new(2015,01,01)
    wage = Wage.create_object(
        :employee_id => 0,
        :effective_date => effective_date,
        :pph21_id => @pph21.id,
        :ptkp_id => @ptkp.id,
        :jamsostek_id => @jamsostek.id
      )
      
    wage.should_not be_valid
  end
  
  it "should not allow object creation without effective date" do
    effective_date = Date.new(2015,01,01)
    wage = Wage.create_object(
        :employee_id => @employee.id,
        :effective_date => "",
        :pph21_id => @pph21.id,
        :ptkp_id => @ptkp.id,
        :jamsostek_id => @jamsostek.id
      )
      
    wage.should_not be_valid
  end
  
  it "should not allow object creation without pph21 id" do
   effective_date = Date.new(2015,01,01)
    wage = Wage.create_object(
        :employee_id => @employee.id,
        :effective_date => effective_date,
        :pph21_id => "",
        :ptkp_id => @ptkp.id,
        :jamsostek_id => @jamsostek.id
      )
      
    wage.should_not be_valid
  end
  
  it "should not allow object creation with invalid pph21 id" do
    effective_date = Date.new(2015,01,01)
    wage = Wage.create_object(
        :employee_id => @employee.id,
        :effective_date => effective_date,
        :pph21_id => 0,
        :ptkp_id => @ptkp.id,
        :jamsostek_id => @jamsostek.id
      )
      
    wage.should_not be_valid
  end
  
  it "should not allow object creation without ptkp id" do
   effective_date = Date.new(2015,01,01)
    wage = Wage.create_object(
        :employee_id => @employee.id,
        :effective_date => effective_date,
        :pph21_id => @pph21.id,
        :ptkp_id => "",
        :jamsostek_id => @jamsostek.id
      )
      
    wage.should_not be_valid
  end
  
  it "should not allow object creation with invalid ptkp id" do
    effective_date = Date.new(2015,01,01)
    wage = Wage.create_object(
        :employee_id => 0,
        :effective_date => effective_date,
        :pph21_id => @pph21.id,
        :ptkp_id => 0,
        :jamsostek_id => @jamsostek.id
      )
      
    wage.should_not be_valid
  end
  
  it "should not allow object creation without jamsostek id" do
   effective_date = Date.new(2015,01,01)
    wage = Wage.create_object(
        :employee_id => @employee.id,
        :effective_date => effective_date,
        :pph21_id => @pph21.id,
        :ptkp_id => @ptkp.id,
        :jamsostek_id => ""
      )
      
    wage.should_not be_valid
  end
  
  it "should not allow object creation with invalid jamsostek id" do
    effective_date = Date.new(2015,01,01)
    wage = Wage.create_object(
        :employee_id => @employee.id,
        :effective_date => effective_date,
        :pph21_id => @pph21.id,
        :ptkp_id => @ptkp.id,
        :jamsostek_id => 0
      )
      
    wage.should_not be_valid
  end
  
  context "has been created wage" do
    before(:each) do
      @wage_1_effective_date = Date.new(2015,01,01)
      @wage = Wage.create_object(
          :employee_id => @employee.id,
          :effective_date => @wage_1_effective_date,
          :pph21_id => @pph21.id,
          :ptkp_id => @ptkp.id,
          :jamsostek_id => @jamsostek.id
        )
        
      @wage_2_effective_date = Date.new(2015,02,01)
      @wage_2 = Wage.create_object(
          :employee_id => @employee.id,
          :effective_date => @wage_2_effective_date,
          :pph21_id => @pph21.id,
          :ptkp_id => @ptkp.id,
          :jamsostek_id => @jamsostek.id
        )
    end
    
    it "should have 2 objects" do
      Wage.count.should == 2 
    end
    
    it "should create valid objects" do
      @wage.should be_valid
      @wage_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_effective_date = Date.new(2015,04,01)
      @wage.update_object(
          :employee_id => @employee.id,
          :effective_date => new_effective_date,
          :pph21_id => @pph21.id,
          :ptkp_id => @ptkp.id,
          :jamsostek_id => @jamsostek.id
        )
        
      @wage.should be_valid
      
      @wage.reload 
      
      @wage.effective_date.should == new_effective_date
    end
    
    it "should be allowed to delete object because it last salary" do
      @wage_2.delete_object
      
      @wage_2.persisted?.should be_falsy  # be_truthy 
      
      Wage.count.should == 1 
    end
    
    it "should not be allowed to delete object because not last salary" do
      @wage.delete_object
      
      @wage.persisted?.should be_truthy  # be_truthy 
      
      Wage.count.should == 2
    end
  end
end
