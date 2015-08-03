require 'rails_helper'

RSpec.describe Pph21NonEmployee, type: :model do
  before (:each) do
      @office = Office.create_object(
            :code => "SSD",
            :name => "Solusi Sentral Data"
          )
      
      @tax_code = TaxCode.create_object(
            :office_id => @office.id,
            :code => "21-100-01",
            :name => "Pegawai Tetap"
          )
  end
  
  it "should allow object creation with nik and name" do
    nik = "1234567890"
    pph21_non_employee = Pph21NonEmployee.create_object(
        :office_id => @office.id,
        :nik => nik,
        :name => "Abdul Ro'uf",
        :tax_code_id => @tax_code.id
      )
      
    pph21_non_employee.should be_valid
    
    pph21_non_employee.nik.should == nik
    pph21_non_employee.name.should == "Abdul Ro'uf"
  end
  
  it "should not allow object creation without office id" do
    nik = "1234567890"
    pph21_non_employee = Pph21NonEmployee.create_object( 
        :office_id => "",
        :nik => nik,
        :name => "Abdul Ro'uf",
        :tax_code_id => @tax_code.id
      )
      
    pph21_non_employee.should_not be_valid
  end
  
  it "should not allow object creation with invalid office id" do
    nik = "1234567890"
    pph21_non_employee = Pph21NonEmployee.create_object( 
        :office_id => 0,
        :nik => nik,
        :name => "Abdul Ro'uf",
        :tax_code_id => @tax_code.id
      )
      
    pph21_non_employee.should_not be_valid
  end
  
  it "should not allow object creation without tax code id" do
    nik = "1234567890"
    pph21_non_employee = Pph21NonEmployee.create_object( 
        :office_id => @office.id,
        :nik => nik,
        :name => "Abdul Ro'uf",
        :tax_code_id => ""
      )
      
    pph21_non_employee.should_not be_valid
  end
  
  it "should not allow object creation with invalid tax code id" do
    nik = "1234567890"
    pph21_non_employee = Pph21NonEmployee.create_object( 
        :office_id => @office.id,
        :nik => nik,
        :name => "Abdul Ro'uf",
        :tax_code_id => 0
      )
      
    pph21_non_employee.should_not be_valid
  end
  
  it "should not allow object creation without name" do
    nik = "1234567890"
    pph21_non_employee = Pph21NonEmployee.create_object( 
        :office_id => @office.id,
        :nik => nik,
        :name => "",
        :tax_code_id => @tax_code.id
      )
      
    pph21_non_employee.should_not be_valid
  end
  
  it "should not allow object creation without nik" do
    nik = "1234567890"
    pph21_non_employee = Pph21NonEmployee.create_object( 
        :office_id => @office.id,
        :nik => "",
        :name => "Abdul Ro'uf",
        :tax_code_id => @tax_code.id
      )
      
    pph21_non_employee.should_not be_valid
  end
  
  it "should not allow object creation with duplicate nik" do
    nik = "1234567890"
    pph21_non_employee =  Pph21NonEmployee.create_object( 
        :office_id => @office.id,
        :nik => nik,
        :name => "Abdul Ro'uf",
        :tax_code_id => @tax_code.id
      )
      
    pph21_non_employee.should be_valid
    
    pph21_non_employee_2 = Pph21NonEmployee.create_object( 
        :office_id => @office.id,
        :nik => nik,
        :name => "Abdul Ro'uf",
        :tax_code_id => @tax_code.id
      )
      
    pph21_non_employee_2.should_not be_valid
  end
  
  context "has been created pph21_non_employee" do
    before(:each) do
      @pph21_non_employee_1_nik = "1234567890"
      @pph21_non_employee_1_name = "Abdul Ro'uf"
      @pph21_non_employee = Pph21NonEmployee.create_object(
          :office_id => @office.id,
          :nik => @pph21_non_employee_1_nik,
          :name => @pph21_non_employee_1_name,
          :tax_code_id => @tax_code.id
        )
        
      @pph21_non_employee_2_nik = "0987654321"
      @pph21_non_employee_2_name = "Riyanto"
      @pph21_non_employee_2 = Pph21NonEmployee.create_object(
          :office_id => @office.id,
          :nik => @pph21_non_employee_2_nik,
          :name => @pph21_non_employee_2_name,
          :tax_code_id => @tax_code.id
        )
    end
    
    it "should have 2 objects" do
      Pph21NonEmployee.count.should == 2 
    end
    
    it "should create valid objects" do
      @pph21_non_employee.should be_valid
      @pph21_non_employee_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_nik = "6543217890"
      new_name = "Bambang"
      
      @pph21_non_employee.update_object(
          :office_id => @office.id,
          :nik => new_nik,
          :name => new_name,
          :tax_code_id => @tax_code.id
        )
        
      @pph21_non_employee.should be_valid
      
      @pph21_non_employee.reload 
      
      @pph21_non_employee.name.should == new_name
      @pph21_non_employee.nik.should == new_nik
    end
    
    it "should not allow duplicate nik" do
      @pph21_non_employee_2.update_object(
          :office_id => @office.id,
          :nik => @pph21_non_employee_1_nik,
          :name => @pph21_non_employee_2_name
        )
        
      @pph21_non_employee_2.errors.size.should_not == 0 
      @pph21_non_employee_2.should_not be_valid
    end
    
    it "should be allowed to delete object 2" do
      @pph21_non_employee_2.delete_object
      
      @pph21_non_employee_2.persisted?.should be_falsy  # be_truthy 
      
      Pph21NonEmployee.count.should == 1 
    end
  end
end
