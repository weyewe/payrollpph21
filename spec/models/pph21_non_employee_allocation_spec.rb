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
      
      @pph21_detail = Pph21Detail.create_object(
            :pph21_id => @pph21.id,
            :percentage => 5,
            :from_value => 0,
            :to_value => 50000000,
            :is_up => false
         )
      
      @pph21_detail_2 = Pph21Detail.create_object(
            :pph21_id => @pph21.id,
            :percentage => 15,
            :from_value => 50000000,
            :to_value => 250000000,
            :is_up => false
         )
      
      @pph21_detail_3 = Pph21Detail.create_object(
            :pph21_id => @pph21.id,
            :percentage => 25,
            :from_value => 250000000,
            :to_value => 500000000,
            :is_up => false
         )
      
      @pph21_detail_4 = Pph21Detail.create_object(
            :pph21_id => @pph21.id,
            :percentage => 30,
            :from_value => 500000000,
            :to_value => 0,
            :is_up => true
         )
         
      @ptkp = Ptkp.create_object(
            :office_id => @office.id,
            :code => "PTKP2013",
            :name => "PTKP Aturan Tahun 2013"
          )
      
      @ptkp_detail = PtkpDetail.create_object(
            :ptkp_id => @ptkp.id,
            :marital_status => MARITAL_STATUS[:single],
            :number_of_children => 0,
            :value => 24300000
          )
          
      @pph21_non_employee = Pph21NonEmployee.create_object(
        :office_id => @office.id,
        :nik => 1,
        :name => "Abdul Ro'uf",
        :address => "Surabaya",
        :npwp => "35.784.562.7-614.000",
        :marital_status => MARITAL_STATUS[:single],
        :number_of_children => 0,
        :tax_code_id => @tax_code.id,
        :npwp_method => TAX_METHOD[:netto]
      ) 
      
      @pph21_non_employee_2 = Pph21NonEmployee.create_object(
        :office_id => @office.id,
        :nik => 2,
        :name => "Pebrian",
        :address => "Surabaya",
        :npwp => "35.784.562.7-614.000",
        :marital_status => MARITAL_STATUS[:single],
        :number_of_children => 0,
        :tax_code_id => @tax_code.id,
        :npwp_method => TAX_METHOD[:gross_up]
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
    
    pph21_non_employee_allocation.bruto_value.should == 1500000
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
          :pph21_non_employee_id => @pph21_non_employee_2.id,
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
    
    it "should have pph21 non employee data for id 1" do
      @pph21_non_employee_allocation.reload
      
      @pph21_non_employee_allocation.dpp_value.should == 750000
      @pph21_non_employee_allocation.prosen_dpp.should == 50
      @pph21_non_employee_allocation.prosen_pph.should == 5
      @pph21_non_employee_allocation.pph21_value.should == 37500
    end
    
    it "should have pph21 non employee data for id 2" do
      @pph21_non_employee_allocation_2.reload
      
      @pph21_non_employee_allocation_2.dpp_value.should == 1026316
      @pph21_non_employee_allocation_2.prosen_dpp.should == 50
      @pph21_non_employee_allocation_2.prosen_pph.should == 5
      @pph21_non_employee_allocation_2.pph21_value.should == 52632
    end
    
    it "should be allowed to update" do
      @pph21_non_employee_allocation.update_object(
          :pph21_non_employee_id => @pph21_non_employee.id,
          :bruto_value => 1750000
        )
        
      @pph21_non_employee_allocation.should be_valid
      
      @pph21_non_employee_allocation.reload 
      
      @pph21_non_employee_allocation.bruto_value.should == 1750000
    end
    
    it "should be allowed to delete object 2" do
      @pph21_non_employee_allocation_2.delete_object
      
      @pph21_non_employee_allocation_2.persisted?.should be_falsy  # be_truthy 
      
      Pph21NonEmployeeAllocation.count.should == 1 
    end
    
    context "has been updated" do
      before (:each) do
        @pph21_non_employee_allocation.update_object(
          :pph21_non_employee_id => @pph21_non_employee.id,
          :bruto_value => 1750000
        )
        
        @pph21_non_employee_allocation_2.update_object(
          :pph21_non_employee_id => @pph21_non_employee_2.id,
          :bruto_value => 2000000
        )
      end
      
      it "should have pph21 non employee data id 1" do
        @pph21_non_employee_allocation.reload
        
        @pph21_non_employee_allocation.dpp_value.should == 875000
        @pph21_non_employee_allocation.prosen_dpp.should == 50
        @pph21_non_employee_allocation.prosen_pph.should == 5
        @pph21_non_employee_allocation.pph21_value.should == 43750
      end
      
      it "should have pph21 non employee data id 2" do
        @pph21_non_employee_allocation_2.reload
        
        @pph21_non_employee_allocation_2.dpp_value.should == 1026316
        @pph21_non_employee_allocation_2.prosen_dpp.should == 50
        @pph21_non_employee_allocation_2.prosen_pph.should == 5
        @pph21_non_employee_allocation_2.pph21_value.should == 52632
      end
      
    end
  end
end
