require 'rails_helper'

RSpec.describe Payroll, type: :model do
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
            :marital_status => 1,
            :number_of_children => 0,
            :value => 26325000
          )
      
      @jamsostek = Jamsostek.create_object(
            :office_id => @office.id,
            :code => "JSTK2013",
            :name => "Jamsostek Aturan Tahun 2013",
            :jkk_percentage => 0.89,
            :jkm_percentage => 0.3,
            :jht_employee_percentage => 2,
            :jht_office_percentage => 3.7,
            :jp_employee_percentage => 1,
            :jp_office_percentage => 2,
            :jp_maximum_salary => 7000000
         )
      
      @tax_code = TaxCode.create_object(
            :office_id => @office.id,
            :code => "21-100-01",
            :name => "Pegawai Tetap"
          )
          
    #   @employee = Employee.create_object(
    #         :office_id => @office.id,
    #         :branch_office_id => @branch_office.id,
    #         :department_id => @department.id,
    #         :division_id => @division.id,
    #         :title_id => @title.id,
    #         :level_id => @level.id,
    #         :status_working_id => @status_working.id,
    #         :code => "007",
    #         :full_name => "Pebrian",
    #         :nick_name => "Pebri",
    #         :enroll_id => 12,
    #         :bank_id => @bank.id,
    #         :no_jamsostek => "JamsostekNumber",
    #         :jamsostek_registered_date => DateTime.new(2015,1,1),
    #         :start_working => DateTime.new(2014,1,1)
    #       )
      
      @employee_2 = Employee.create_object(
            :office_id => @office.id,
            :branch_office_id => @branch_office.id,
            :department_id => @department.id,
            :division_id => @division.id,
            :title_id => @title.id,
            :level_id => @level.id,
            :status_working_id => @status_working.id,
            :code => "008",
            :full_name => "Abdul Ro'uf",
            :nick_name => "Abdul",
            :enroll_id => 13,
            :bank_id => @bank.id,
            :no_jamsostek => "JamsostekNumber",
            :jamsostek_registered_date => DateTime.new(2015,1,1),
            :start_working => DateTime.new(2015,8,5)
          )
      
    #   @wage_taxation = WageTaxation.create_object(
    #         :employee_id => @employee.id,
    #         :effective_date => DateTime.new(2015,8,1),
    #         :tax_code_id => @tax_code.id,
    #         :marital_status => MARITAL_STATUS[:single],
    #         :number_of_children => 0,
    #         :tax_method => TAX_METHOD[:netto]
    #   )
      
      @wage_taxation_2 = WageTaxation.create_object(
            :employee_id => @employee_2.id,
            :effective_date => DateTime.new(2015,8,1),
            :tax_code_id => @tax_code.id,
            :marital_status => MARITAL_STATUS[:single],
            :number_of_children => 0,
            :tax_method => TAX_METHOD[:netto]
      )
      
    #   @wage = Wage.create_object(
    #         :employee_id => @employee.id,
    #         :effective_date => DateTime.new(2015,8,1),
    #         :pph21_id => @pph21.id,
    #         :ptkp_id => @ptkp.id,
    #         :jamsostek_id => @jamsostek.id,
    #         :is_daily_basic => false,
    #         :basic_salary => 3500000,
    #         :is_daily_seniority => false,
    #         :seniority_allowance => 500000,
    #         :is_daily_functional => false,
    #         :functional_allowance => 300000,
    #         :is_daily_meal => false,
    #         :meal_allowance => 350000,
    #         :is_daily_transport => false,
    #         :transport_allowance => 350000,
    #         :is_daily_communication => false,
    #         :communication_allowance => 100000,
    #         :is_daily_medical => false,
    #         :medical_allowance => 120000,
    #   )
      
      @wage_2 = Wage.create_object(
            :employee_id => @employee_2.id,
            :effective_date => DateTime.new(2015,8,1),
            :pph21_id => @pph21.id,
            :ptkp_id => @ptkp.id,
            :jamsostek_id => @jamsostek.id,
            :is_daily_basic => false,
            :basic_salary => 2000000
      )
      
      @shift = Shift.create_object(
            :office_id => @office.id,
            :code => "SFT",
            :name => "SHIFT",
            :start_time => 480,
            :duration => 8
          )
      
      @shift_detail = ShiftDetail.create_object(
            :shift_id => @shift.id,
            :day_code => DAY_CODE[:sunday],
            :start_time => 480,
            :duration => 8
         )
      
      @shift_detail_2 = ShiftDetail.create_object(
            :shift_id => @shift.id,
            :day_code => DAY_CODE[:monday],
            :start_time => 480,
            :duration => 8
         )
      
      @shift_detail_3 = ShiftDetail.create_object(
            :shift_id => @shift.id,
            :day_code => DAY_CODE[:tuesday],
            :start_time => 480,
            :duration => 8
         )
      
      @shift_detail_4 = ShiftDetail.create_object(
            :shift_id => @shift.id,
            :day_code => DAY_CODE[:wednesday],
            :start_time => 480,
            :duration => 8
         )
      
      @shift_detail_5 = ShiftDetail.create_object(
            :shift_id => @shift.id,
            :day_code => DAY_CODE[:thursday],
            :start_time => 480,
            :duration => 8
         )
      
      @shift_detail_6 = ShiftDetail.create_object(
            :shift_id => @shift.id,
            :day_code => DAY_CODE[:friday],
            :start_time => 480,
            :duration => 8
         )
      
      @shift_detail_7 = ShiftDetail.create_object(
            :shift_id => @shift.id,
            :day_code => DAY_CODE[:saturday],
            :start_time => 480,
            :duration => 6
         )
         
    #   @attendance_1 = Attendance.create_object(
    #         :employee_id => @employee.id,
    #         :shift_id => @shift.id,
    #         :date => DateTime.new(2015,8,1),
    #         :status => ATTENDANCE_STATUS[:present],
    #         :time_in => 480,
    #         :time_out => 1020
    #      )
      
      @attendance_2 = Attendance.create_object(
            :employee_id => @employee_2.id,
            :shift_id => @shift.id,
            :date => DateTime.new(2015,8,1),
            :status => ATTENDANCE_STATUS[:present],
            :time_in => 480,
            :time_out => 1020
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
      
      @bpjs_percentage = BpjsPercentage.create_object(
            :office_id => @office.id,
            :employee_percentage => 1,
            :office_percentage => 4,
            :max_of_children => 3
         )
      
    #   @bpjs_insurance = BpjsInsurance.create_object(
    #         :employee_id => @employee.id,
    #         :date => DateTime.new(2015,8,1),
    #         :no => "JK102910",
    #         :premi => 3500000,
    #         :is_active => true
    #      )
      
      @bpjs_insurance_2 = BpjsInsurance.create_object(
            :employee_id => @employee_2.id,
            :date => DateTime.new(2015,8,1),
            :no => "JK102910",
            :premi => 3500000,
            :is_active => true
         )
    
    #   @loan = Loan.create_object(
    #         :employee_id => @employee.id,
    #         :date => DateTime.new(2015,8,1),
    #         :value => 1000000,
    #         :interest => 0,
    #         :total => 1000000,
    #         :installment_time => 1,
    #         :installment_value => 1000000,
    #         :installment_start => DateTime.new(2015,8,1),
    #         :installment_end => DateTime.new(2015,8,1)
    #       )
      
    #   @loan = Loan.create_object(
    #         :employee_id => @employee_2.id,
    #         :date => DateTime.new(2015,8,1),
    #         :value => 1000000,
    #         :interest => 0,
    #         :total => 1000000,
    #         :installment_time => 1,
    #         :installment_value => 1000000,
    #         :installment_start => DateTime.new(2015,8,1),
    #         :installment_end => DateTime.new(2015,8,1)
    #       )
    
    #   @other_income = OtherIncome.create_object(
    #         :employee_id => @employee.id,
    #         :date => DateTime.new(2015,8,1),
    #         :is_taxable => true,
    #         :value => 150000
    #       )
      
      @overtime = Overtime.create_object(
            :office_id => @office.id,
            :code => "HK",
            :name => "Overtime di Hari Kerja"
          )
      
      @overtime_2 = Overtime.create_object(
            :office_id => @office.id,
            :code => "HL",
            :name => "Overtime di Hari Libur"
          )
      
      @overtime_detail_overtime1 = OvertimeDetail.create_object(
            :overtime_id => @overtime.id,
            :multiplier => 1.5,
            :from_value => 0,
            :to_value => 1
          )
          
      @overtime_detail_overtime1_2 = OvertimeDetail.create_object(
            :overtime_id => @overtime.id,
            :multiplier => 2,
            :from_value => 1,
            :to_value => 24
          )
      
      @overtime_detail_overtime2 = OvertimeDetail.create_object(
            :overtime_id => @overtime_2.id,
            :multiplier => 2,
            :from_value => 0,
            :to_value => 7
          )
          
      @overtime_detail_overtime2_2 = OvertimeDetail.create_object(
            :overtime_id => @overtime_2.id,
            :multiplier => 3,
            :from_value => 7,
            :to_value => 8
          )
      
      @overtime_detail_overtime2_3 = OvertimeDetail.create_object(
            :overtime_id => @overtime_2.id,
            :multiplier => 4,
            :from_value => 8,
            :to_value => 24
          )
      
    #   @overtime_allocation = OvertimeAllocation.create_object(
    #     :employee_id => @employee.id,
    #     :overtime_id => @overtime.id,
    #     :date => DateTime.new(2015,8,1),
    #     :start_time => 600,
    #     :end_time => 960,
    #     :description => "Overtime 1"
    #   )
      
    #   @overtime_allocation_2 = OvertimeAllocation.create_object(
    #     :employee_id => @employee.id,
    #     :overtime_id => @overtime_2.id,
    #     :date => DateTime.new(2015,8,2),
    #     :start_time => 600,
    #     :end_time => 1200,
    #     :description => "Overtime 2"
    #   )
      
    #   @overtime_allocation.approve_object
    #   @overtime_allocation_2.approve_object
  end
  
  it "should have employee" do
    #   @employee.should be_valid
      @employee_2.should be_valid
  end
  
  it "should allow object creation with all required field" do
    payroll = Payroll.create_object(
        :office_id => @office.id,
        :month => DateTime.new(2015,8,1),
        :start_date => DateTime.new(2015,8,1),
        :end_date => DateTime.new(2015,8,31)
      )
      
    payroll.should be_valid
  end
  
  it "should not allow object creation without office id" do
    payroll = Payroll.create_object( 
        :office_id => "",
        :month => DateTime.new(2015,8,1),
        :start_date => DateTime.new(2015,8,1),
        :end_date => DateTime.new(2015,8,31)
      )
      
    payroll.should_not be_valid
  end
  
  it "should not allow object creation with invalid office id" do
    payroll = Payroll.create_object( 
        :office_id => 0,
        :month => DateTime.new(2015,8,1),
        :start_date => DateTime.new(2015,8,1),
        :end_date => DateTime.new(2015,8,31)
      )
      
    payroll.should_not be_valid
  end
  
  it "should not allow object creation without month" do
    payroll = Payroll.create_object( 
        :office_id => @office.id,
        :month => "",
        :start_date => DateTime.new(2015,8,1),
        :end_date => DateTime.new(2015,8,31)
      )
      
    payroll.should_not be_valid
  end
  
  it "should not allow object creation without start_date" do
    payroll = Payroll.create_object( 
        :office_id => @office.id,
        :month => DateTime.new(2015,8,1),
        :start_date => "",
        :end_date => DateTime.new(2015,8,31)
      )
      
    payroll.should_not be_valid
  end
  
  it "should not allow object creation without end_date" do
    payroll = Payroll.create_object( 
        :office_id => @office.id,
        :month => DateTime.new(2015,8,1),
        :start_date => DateTime.new(2015,8,1),
        :end_date =>""
      )
      
    payroll.should_not be_valid
  end
  
  context "has been created payroll" do
    before(:each) do
      @payroll = Payroll.create_object(
          :office_id => @office.id,
          :month => DateTime.new(2015,8,1),
          :start_date => DateTime.new(2015,8,1),
          :end_date => DateTime.new(2015,8,31)
        )
    end
    
    it "should have 2 objects" do
      Payroll.count.should == 1 
    end
    
    it "should create valid objects" do
      @payroll.should be_valid
    end
    
    it "should be allowed to delete object 2" do
      @payroll.delete_object
      
      @payroll.persisted?.should be_falsy  # be_truthy 
      
      Payroll.count.should == 0
    end
    
    # it "should calculate salary salary for employeee x" do
    #   current_employee_id = @employee.id
      
    #   object_salary = WageTransaction.where{
    #       (employee_id.eq current_employee_id) &
    #       (year.eq DateTime.new(2015,8,1).year) &
    #       (month.eq DateTime.new(2015,8,1).month)
    #     }.first
      
    #   object_salary.basic_salary.should == 3500000
    #   object_salary.seniority_allowance.should == 500000
    #   object_salary.functional_allowance.should == 300000
    #   object_salary.meal_allowance.should == 350000
    #   object_salary.transport_allowance.should == 350000
    #   object_salary.phone_allowance.should == 100000
    #   object_salary.medical_allowance.should == 120000
    #   object_salary.overtime.should == 738439
    #   object_salary.pph21_allowance.should == 0
    #   object_salary.other_allowance_taxable.should == 150000
    #   object_salary.other_allowance_non_taxable.should == 0
    #   object_salary.thr.should == 0
    #   object_salary.commission.should == 0
    #   object_salary.jkk.should == 31150
    #   object_salary.jkm.should == 10500
    #   object_salary.jht_company.should == 129500
    #   object_salary.jp_company.should == 70000
    #   object_salary.bpjs_company.should == 140000
    #   object_salary.other_expense_taxable.should == 0
    #   object_salary.other_expense_non_taxable.should == 0
    #   object_salary.loan.should == 1000000
    #   object_salary.cooperative_dues.should == 0
    #   object_salary.jht_employee.should == 70000
    #   object_salary.jp_employee.should == 35000
    #   object_salary.bpjs_employee.should == 35000
    #   object_salary.bruto.should == 6290089 
    #   object_salary.biaya_jabatan.should == 314504.45
    #   object_salary.netto.should == 5870584.55
    #   object_salary.netto_yearly.should == 70447015
    #   object_salary.ptkp.should == 26325000
    #   object_salary.pkp.should == 44122000
    #   object_salary.pph_yearly.should == 2206100
    #   object_salary.pph21_value.should == 183841
    #   object_salary.pph21_non_npwp.should == 36768
    #   object_salary.sisa_gaji.should == 4747830
    # end
    
    # it "should calculate loan salary for employeee x" do
    #   current_employee_id = @employee.id
      
    #   LoanDetail.joins(:loan).where{
    #       (loan.employee_id.eq current_employee_id) &
    #       (strftime("%Y-%m-%d",month).gte DateTime.new(2015,8,1).to_date) &
    #         (strftime("%Y-%m-%d",month).lte DateTime.new(2015,8,31).to_date)
    #     }.each do |inst|
    #         inst.is_paid.should be_truthy
    #     end
    # end
  end
end
