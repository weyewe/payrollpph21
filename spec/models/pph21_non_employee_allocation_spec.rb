require 'rails_helper'

RSpec.describe Pph21NonEmployeeAllocation, type: :model do
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
      
      @pph21 = Pph21.create_object(
            :office_id => @office.id,
            :code => "PPH212013",
            :name => "PPh21 Aturan Tahun 2013"
          )
          
      @pph21_non_employee = Pph21NonEmployee.create_object(
            :office_id => @office.id,
            :nik => 1,
            :name => "Abdul Ro'uf",
            :npwp => "35.784.562.7-614.000",
            :tax_code_id => @tax_code.id
          )
      
      @preference = Preference.create_object(
            :office_id => @office.id,
            :ot_divider => 173,
            :biaya_jabatan_percentage => 5,
            :biaya_jabatan_max => 500000,
            :pph_non_npwp_percentage => 20,
            :dpp_percentage => 50,
            :pph21_id => @pph21.id
          )
  end
  
  it "should allow object creation with code and name" do
    pph21_non_employee_allocation = Pph21NonEmployeeAllocation.create_object(
        :pph21_non_employee_id => @pph21_non_employee.id,
        :bruto_value => 1500000
      )
      
    pph21_non_employee_allocation.should be_valid
  end
  
  it "should not allow object creation without non employee id" do
    pph21_non_employee_allocation = Pph21NonEmployeeAllocation.create_object( 
        :pph21_non_employee_id => "",
        :bruto_value =>1500000
      )
      
    pph21_non_employee_allocation.should_not be_valid
  end
  
  it "should not allow object creation with invalid non employee id" do
    pph21_non_employee_allocation = Pph21NonEmployeeAllocation.create_object( 
        :pph21_non_employee_id => 0,
        :bruto_value => 1500000
      )
      
    pph21_non_employee_allocation.should_not be_valid
  end
  
  context "has been created pph21_non_employee_allocation" do
    before(:each) do
      @pph21_non_employee_allocation = Pph21NonEmployeeAllocation.create_object(
          :pph21_non_employee_id => @pph21_non_employee.id,
          :bruto_value => 1500000
        )
        
      @pph21_non_employee_allocation_2 = Pph21NonEmployeeAllocation.create_object(
          :pph21_non_employee_id => @pph21_non_employee.id,
          :bruto_value => 2000000
        )
    end
    
    it "should have 2 objects" do
      Pph21NonEmployeeAllocation.count.should == 2 
    end
    
    it "should create valid objects" do
      @pph21_non_employee_allocation.should be_valid
      @pph21_non_employee_allocation_2.should be_valid
    end
    
    it "should be allowed to update" do
      @pph21_non_employee_allocation.update_object(
          :pph21_non_employee_id => @pph21_non_employee.id,
          :bruto_value => 1750000
        )
        
      @pph21_non_employee_allocation.should be_valid
      
      @pph21_non_employee_allocation.reload 
    end
    
    it "should be allowed to delete object 2" do
      @pph21_non_employee_allocation_2.delete_object
      
      @pph21_non_employee_allocation_2.persisted?.should be_falsy  # be_truthy 
      
      Pph21NonEmployeeAllocation.count.should == 1 
    end
  end
end
