require 'rails_helper'

RSpec.describe WageTransaction, type: :model do
  # before (:each) do
  #     @office = Office.create_object(
  #           :code => "SSD",
  #           :name => "Solusi Sentral Data"
  #         )
          
  #     @branch_office = BranchOffice.create_object(
  #           :office_id => @office.id,
  #           :code => "SSDSUB",
  #           :name => "Solusi Sentral Data - Surabaya"
  #         )
          
  #     @department = Department.create_object(
  #           :office_id => @office.id,
  #           :branch_office_id => @branch_office.id,
  #           :code => "IT",
  #           :name => "IT"
  #         )
     
  #     @division = Division.create_object(
  #           :office_id => @office.id,
  #           :branch_office_id => @branch_office.id,
  #           :department_id => @department.id,
  #           :code => "007",
  #           :name => "Programmer"
  #         )
      
  #     @title = Title.create_object(
  #           :office_id => @office.id,
  #           :code => "J007",
  #           :name => "Junior Programmer"
  #         )
      
  #     @level = Level.create_object(
  #           :office_id => @office.id,
  #           :code => "STF",
  #           :name => "Staff"
  #         )
      
  #     @status_working = StatusWorking.create_object(
  #           :office_id => @office.id,
  #           :code => "PMT",
  #           :name => "Permanent"
  #         )
      
  #     @bank = Bank.create_object(
  #           :office_id => @office.id,
  #           :code => "BCA",
  #           :name => "Bank Central Asia"
  #         )
      
  #     @employee = Employee.create_object(
  #           :office_id => @office.id,
  #           :branch_office_id => @branch_office.id,
  #           :department_id => @department.id,
  #           :division_id => @division.id,
  #           :title_id => @title.id,
  #           :level_id => @level.id,
  #           :status_working_id => @status_working.id,
  #           :code => "007",
  #           :full_name => "Pebrian",
  #           :nick_name => "Pebri",
  #           :enroll_id => 12,
  #           :bank_id => @bank.id,
  #           :start_working => DateTime.new(2014,1,1)
  #         )
  # end
  
  # it "should allow object creation with all field required" do
  #   date = DateTime.new(2015,8,15) 
    
  #   # date.month.to_i.should  == 8 
  #   # date.year.to_i.should == 2015
    
  #   # date.day.to_i.should == 15
    
  #   wage_transaction = WageTransaction.create_object(
  #       :employee_id => @employee.id,
  #       :year => date.year.to_i,
  #       :month => date.month.to_i,
  #       :basic_salary => 2200000,
  #       :seniority_allowance => 0,
  #       :functional_allowance => 0,
  #       :meal_allowance => 0,
  #       :transport_allowance => 0,
  #       :phone_allowance => 0,
  #       :medical_allowance => 0,
  #       :overtime => 0,
  #       :pph21_allowance => 0,
  #       :other_allowance_taxable => 0,
  #       :other_allowance_non_taxable => 0,
  #       :thr => 0,
  #       :commission => 0,
  #       :jkk => 0,
  #       :jkm => 0,
  #       :jht_company => 0,
  #       :bpjs_company => 0,
  #       :other_expense_taxable => 0,
  #       :other_expense_non_taxable => 0,
  #       :loan => 0,
  #       :cooperative_dues => 0,
  #       :jht_employee => 0,
  #       :bpjs_employee => 0,
  #       :pph21_value => 0
  #     )
      
  #   wage_transaction.should be_valid
    
  #   wage_transaction.year.should == date.year.to_i
  #   wage_transaction.month.should == date.month.to_i
  # end
  
  # it "should allow object creation without year" do
  #   date = DateTime.new(2015,1,1)
  #   wage_transaction = WageTransaction.create_object(
  #       :employee_id => @employee.id,
  #       :year => "",
  #       :month => date.month.to_i,
  #       :basic_salary => 2200000,
  #       :seniority_allowance => 0,
  #       :functional_allowance => 0,
  #       :meal_allowance => 0,
  #       :transport_allowance => 0,
  #       :phone_allowance => 0,
  #       :medical_allowance => 0,
  #       :overtime => 0,
  #       :pph21_allowance => 0,
  #       :other_allowance_taxable => 0,
  #       :other_allowance_non_taxable => 0,
  #       :thr => 0,
  #       :commission => 0,
  #       :jkk => 0,
  #       :jkm => 0,
  #       :jht_company => 0,
  #       :bpjs_company => 0,
  #       :other_expense_taxable => 0,
  #       :other_expense_non_taxable => 0,
  #       :loan => 0,
  #       :cooperative_dues => 0,
  #       :jht_employee => 0,
  #       :bpjs_employee => 0,
  #       :pph21_value => 0
  #     )
      
  #   wage_transaction.should_not be_valid
  # end
  
  # it "should allow object creation without month" do
  #   date = DateTime.new(2015,1,1)
  #   wage_transaction = WageTransaction.create_object(
  #       :employee_id => @employee.id,
  #       :year => date.year.to_i,
  #       :month => "",
  #       :basic_salary => 2200000,
  #       :seniority_allowance => 0,
  #       :functional_allowance => 0,
  #       :meal_allowance => 0,
  #       :transport_allowance => 0,
  #       :phone_allowance => 0,
  #       :medical_allowance => 0,
  #       :overtime => 0,
  #       :pph21_allowance => 0,
  #       :other_allowance_taxable => 0,
  #       :other_allowance_non_taxable => 0,
  #       :thr => 0,
  #       :commission => 0,
  #       :jkk => 0,
  #       :jkm => 0,
  #       :jht_company => 0,
  #       :bpjs_company => 0,
  #       :other_expense_taxable => 0,
  #       :other_expense_non_taxable => 0,
  #       :loan => 0,
  #       :cooperative_dues => 0,
  #       :jht_employee => 0,
  #       :bpjs_employee => 0,
  #       :pph21_value => 0
  #     )
      
  #   wage_transaction.should_not be_valid
  # end
  
  # it "should allow object creation without basic salary" do
  #   date = DateTime.new(2015,1,1)
  #   wage_transaction = WageTransaction.create_object(
  #       :employee_id => @employee.id,
  #       :year => date.year.to_i,
  #       :month => date.month.to_i,
  #       :basic_salary => "",
  #       :seniority_allowance => 0,
  #       :functional_allowance => 0,
  #       :meal_allowance => 0,
  #       :transport_allowance => 0,
  #       :phone_allowance => 0,
  #       :medical_allowance => 0,
  #       :overtime => 0,
  #       :pph21_allowance => 0,
  #       :other_allowance_taxable => 0,
  #       :other_allowance_non_taxable => 0,
  #       :thr => 0,
  #       :commission => 0,
  #       :jkk => 0,
  #       :jkm => 0,
  #       :jht_company => 0,
  #       :bpjs_company => 0,
  #       :other_expense_taxable => 0,
  #       :other_expense_non_taxable => 0,
  #       :loan => 0,
  #       :cooperative_dues => 0,
  #       :jht_employee => 0,
  #       :bpjs_employee => 0,
  #       :pph21_value => 0
  #     )
      
  #   wage_transaction.should_not be_valid
  # end
  
  # it "should allow object creation without seniority allowance" do
  #   date = DateTime.new(2015,1,1)
  #   wage_transaction = WageTransaction.create_object(
  #       :employee_id => @employee.id,
  #       :year => date.year.to_i,
  #       :month => date.month.to_i,
  #       :basic_salary => 2200000,
  #       :seniority_allowance => "",
  #       :functional_allowance => 0,
  #       :meal_allowance => 0,
  #       :transport_allowance => 0,
  #       :phone_allowance => 0,
  #       :medical_allowance => 0,
  #       :overtime => 0,
  #       :pph21_allowance => 0,
  #       :other_allowance_taxable => 0,
  #       :other_allowance_non_taxable => 0,
  #       :thr => 0,
  #       :commission => 0,
  #       :jkk => 0,
  #       :jkm => 0,
  #       :jht_company => 0,
  #       :bpjs_company => 0,
  #       :other_expense_taxable => 0,
  #       :other_expense_non_taxable => 0,
  #       :loan => 0,
  #       :cooperative_dues => 0,
  #       :jht_employee => 0,
  #       :bpjs_employee => 0,
  #       :pph21_value => 0
  #     )
      
  #   wage_transaction.should_not be_valid
  # end
  
  # it "should allow object creation without functional allowance" do
  #   date = DateTime.new(2015,1,1)
  #   wage_transaction = WageTransaction.create_object(
  #       :employee_id => @employee.id,
  #       :year => date.year.to_i,
  #       :month => date.month.to_i,
  #       :basic_salary => 2200000,
  #       :seniority_allowance => 0,
  #       :functional_allowance => "",
  #       :meal_allowance => 0,
  #       :transport_allowance => 0,
  #       :phone_allowance => 0,
  #       :medical_allowance => 0,
  #       :overtime => 0,
  #       :pph21_allowance => 0,
  #       :other_allowance_taxable => 0,
  #       :other_allowance_non_taxable => 0,
  #       :thr => 0,
  #       :commission => 0,
  #       :jkk => 0,
  #       :jkm => 0,
  #       :jht_company => 0,
  #       :bpjs_company => 0,
  #       :other_expense_taxable => 0,
  #       :other_expense_non_taxable => 0,
  #       :loan => 0,
  #       :cooperative_dues => 0,
  #       :jht_employee => 0,
  #       :bpjs_employee => 0,
  #       :pph21_value => 0
  #     )
      
  #   wage_transaction.should_not be_valid
  # end
  
  # it "should allow object creation without meal allowance" do
  #   date = DateTime.new(2015,1,1)
  #   wage_transaction = WageTransaction.create_object(
  #       :employee_id => @employee.id,
  #       :year => date.year.to_i,
  #       :month => date.month.to_i,
  #       :basic_salary => 2200000,
  #       :seniority_allowance => 0,
  #       :functional_allowance => 0,
  #       :meal_allowance => "",
  #       :transport_allowance => 0,
  #       :phone_allowance => 0,
  #       :medical_allowance => 0,
  #       :overtime => 0,
  #       :pph21_allowance => 0,
  #       :other_allowance_taxable => 0,
  #       :other_allowance_non_taxable => 0,
  #       :thr => 0,
  #       :commission => 0,
  #       :jkk => 0,
  #       :jkm => 0,
  #       :jht_company => 0,
  #       :bpjs_company => 0,
  #       :other_expense_taxable => 0,
  #       :other_expense_non_taxable => 0,
  #       :loan => 0,
  #       :cooperative_dues => 0,
  #       :jht_employee => 0,
  #       :bpjs_employee => 0,
  #       :pph21_value => 0
  #     )
      
  #   wage_transaction.should_not be_valid
  # end
  
  # it "should allow object creation without transport allowance" do
  #   date = DateTime.new(2015,1,1)
  #   wage_transaction = WageTransaction.create_object(
  #       :employee_id => @employee.id,
  #       :year => date.year.to_i,
  #       :month => date.month.to_i,
  #       :basic_salary => 2200000,
  #       :seniority_allowance => 0,
  #       :functional_allowance => 0,
  #       :meal_allowance => 0,
  #       :transport_allowance => "",
  #       :phone_allowance => 0,
  #       :medical_allowance => 0,
  #       :overtime => 0,
  #       :pph21_allowance => 0,
  #       :other_allowance_taxable => 0,
  #       :other_allowance_non_taxable => 0,
  #       :thr => 0,
  #       :commission => 0,
  #       :jkk => 0,
  #       :jkm => 0,
  #       :jht_company => 0,
  #       :bpjs_company => 0,
  #       :other_expense_taxable => 0,
  #       :other_expense_non_taxable => 0,
  #       :loan => 0,
  #       :cooperative_dues => 0,
  #       :jht_employee => 0,
  #       :bpjs_employee => 0,
  #       :pph21_value => 0
  #     )
      
  #   wage_transaction.should_not be_valid
  # end
  
  # it "should allow object creation without phone allowance" do
  #   date = DateTime.new(2015,1,1)
  #   wage_transaction = WageTransaction.create_object(
  #       :employee_id => @employee.id,
  #       :year => date.year.to_i,
  #       :month => date.month.to_i,
  #       :basic_salary => 2200000,
  #       :seniority_allowance => 0,
  #       :functional_allowance => 0,
  #       :meal_allowance => 0,
  #       :transport_allowance => 0,
  #       :phone_allowance => "",
  #       :medical_allowance => 0,
  #       :overtime => 0,
  #       :pph21_allowance => 0,
  #       :other_allowance_taxable => 0,
  #       :other_allowance_non_taxable => 0,
  #       :thr => 0,
  #       :commission => 0,
  #       :jkk => 0,
  #       :jkm => 0,
  #       :jht_company => 0,
  #       :bpjs_company => 0,
  #       :other_expense_taxable => 0,
  #       :other_expense_non_taxable => 0,
  #       :loan => 0,
  #       :cooperative_dues => 0,
  #       :jht_employee => 0,
  #       :bpjs_employee => 0,
  #       :pph21_value => 0
  #     )
      
  #   wage_transaction.should_not be_valid
  # end
  
  # it "should allow object creation without medical allowance" do
  #   date = DateTime.new(2015,1,1)
  #   wage_transaction = WageTransaction.create_object(
  #       :employee_id => @employee.id,
  #       :year => date.year.to_i,
  #       :month => date.month.to_i,
  #       :basic_salary => 2200000,
  #       :seniority_allowance => 0,
  #       :functional_allowance => 0,
  #       :meal_allowance => 0,
  #       :transport_allowance => 0,
  #       :phone_allowance => 0,
  #       :medical_allowance => "",
  #       :overtime => 0,
  #       :pph21_allowance => 0,
  #       :other_allowance_taxable => 0,
  #       :other_allowance_non_taxable => 0,
  #       :thr => 0,
  #       :commission => 0,
  #       :jkk => 0,
  #       :jkm => 0,
  #       :jht_company => 0,
  #       :bpjs_company => 0,
  #       :other_expense_taxable => 0,
  #       :other_expense_non_taxable => 0,
  #       :loan => 0,
  #       :cooperative_dues => 0,
  #       :jht_employee => 0,
  #       :bpjs_employee => 0,
  #       :pph21_value => 0
  #     )
      
  #   wage_transaction.should_not be_valid
  # end
  
  # it "should allow object creation without overtime" do
  #   date = DateTime.new(2015,1,1)
  #   wage_transaction = WageTransaction.create_object(
  #       :employee_id => @employee.id,
  #       :year => date.year.to_i,
  #       :month => date.month.to_i,
  #       :basic_salary => 2200000,
  #       :seniority_allowance => 0,
  #       :functional_allowance => 0,
  #       :meal_allowance => 0,
  #       :transport_allowance => 0,
  #       :phone_allowance => 0,
  #       :medical_allowance => 0,
  #       :overtime => "",
  #       :pph21_allowance => 0,
  #       :other_allowance_taxable => 0,
  #       :other_allowance_non_taxable => 0,
  #       :thr => 0,
  #       :commission => 0,
  #       :jkk => 0,
  #       :jkm => 0,
  #       :jht_company => 0,
  #       :bpjs_company => 0,
  #       :other_expense_taxable => 0,
  #       :other_expense_non_taxable => 0,
  #       :loan => 0,
  #       :cooperative_dues => 0,
  #       :jht_employee => 0,
  #       :bpjs_employee => 0,
  #       :pph21_value => 0
  #     )
      
  #   wage_transaction.should_not be_valid
  # end
  
  # it "should allow object creation without pph21 allowance" do
  #   date = DateTime.new(2015,1,1)
  #   wage_transaction = WageTransaction.create_object(
  #       :employee_id => @employee.id,
  #       :year => date.year.to_i,
  #       :month => date.month.to_i,
  #       :basic_salary => 2200000,
  #       :seniority_allowance => 0,
  #       :functional_allowance => 0,
  #       :meal_allowance => 0,
  #       :transport_allowance => 0,
  #       :phone_allowance => 0,
  #       :medical_allowance => 0,
  #       :overtime => 0,
  #       :pph21_allowance => "",
  #       :other_allowance_taxable => 0,
  #       :other_allowance_non_taxable => 0,
  #       :thr => 0,
  #       :commission => 0,
  #       :jkk => 0,
  #       :jkm => 0,
  #       :jht_company => 0,
  #       :bpjs_company => 0,
  #       :other_expense_taxable => 0,
  #       :other_expense_non_taxable => 0,
  #       :loan => 0,
  #       :cooperative_dues => 0,
  #       :jht_employee => 0,
  #       :bpjs_employee => 0,
  #       :pph21_value => 0
  #     )
      
  #   wage_transaction.should_not be_valid
  # end
  
  # it "should allow object creation without other allowance taxable" do
  #   date = DateTime.new(2015,1,1)
  #   wage_transaction = WageTransaction.create_object(
  #       :employee_id => @employee.id,
  #       :year => date.year.to_i,
  #       :month => date.month.to_i,
  #       :basic_salary => 2200000,
  #       :seniority_allowance => 0,
  #       :functional_allowance => 0,
  #       :meal_allowance => 0,
  #       :transport_allowance => 0,
  #       :phone_allowance => 0,
  #       :medical_allowance => 0,
  #       :overtime => 0,
  #       :pph21_allowance => 0,
  #       :other_allowance_taxable => "",
  #       :other_allowance_non_taxable => 0,
  #       :thr => 0,
  #       :commission => 0,
  #       :jkk => 0,
  #       :jkm => 0,
  #       :jht_company => 0,
  #       :bpjs_company => 0,
  #       :other_expense_taxable => 0,
  #       :other_expense_non_taxable => 0,
  #       :loan => 0,
  #       :cooperative_dues => 0,
  #       :jht_employee => 0,
  #       :bpjs_employee => 0,
  #       :pph21_value => 0
  #     )
      
  #   wage_transaction.should_not be_valid
  # end
  
  # it "should allow object creation without other allowance non taxable" do
  #   date = DateTime.new(2015,1,1)
  #   wage_transaction = WageTransaction.create_object(
  #       :employee_id => @employee.id,
  #       :year => date.year.to_i,
  #       :month => date.month.to_i,
  #       :basic_salary => 2200000,
  #       :seniority_allowance => 0,
  #       :functional_allowance => 0,
  #       :meal_allowance => 0,
  #       :transport_allowance => 0,
  #       :phone_allowance => 0,
  #       :medical_allowance => 0,
  #       :overtime => 0,
  #       :pph21_allowance => 0,
  #       :other_allowance_taxable => 0,
  #       :other_allowance_non_taxable => "",
  #       :thr => 0,
  #       :commission => 0,
  #       :jkk => 0,
  #       :jkm => 0,
  #       :jht_company => 0,
  #       :bpjs_company => 0,
  #       :other_expense_taxable => 0,
  #       :other_expense_non_taxable => 0,
  #       :loan => 0,
  #       :cooperative_dues => 0,
  #       :jht_employee => 0,
  #       :bpjs_employee => 0,
  #       :pph21_value => 0
  #     )
      
  #   wage_transaction.should_not be_valid
  # end
  
  # it "should allow object creation without thr" do
  #   date = DateTime.new(2015,1,1)
  #   wage_transaction = WageTransaction.create_object(
  #       :employee_id => @employee.id,
  #       :year => date.year.to_i,
  #       :month => date.month.to_i,
  #       :basic_salary => 2200000,
  #       :seniority_allowance => 0,
  #       :functional_allowance => 0,
  #       :meal_allowance => 0,
  #       :transport_allowance => 0,
  #       :phone_allowance => 0,
  #       :medical_allowance => 0,
  #       :overtime => 0,
  #       :pph21_allowance => 0,
  #       :other_allowance_taxable => 0,
  #       :other_allowance_non_taxable => 0,
  #       :thr => "",
  #       :commission => 0,
  #       :jkk => 0,
  #       :jkm => 0,
  #       :jht_company => 0,
  #       :bpjs_company => 0,
  #       :other_expense_taxable => 0,
  #       :other_expense_non_taxable => 0,
  #       :loan => 0,
  #       :cooperative_dues => 0,
  #       :jht_employee => 0,
  #       :bpjs_employee => 0,
  #       :pph21_value => 0
  #     )
      
  #   wage_transaction.should_not be_valid
  # end
  
  # it "should allow object creation without commission" do
  #   date = DateTime.new(2015,1,1)
  #   wage_transaction = WageTransaction.create_object(
  #       :employee_id => @employee.id,
  #       :year => date.year.to_i,
  #       :month => date.month.to_i,
  #       :basic_salary => 2200000,
  #       :seniority_allowance => 0,
  #       :functional_allowance => 0,
  #       :meal_allowance => 0,
  #       :transport_allowance => 0,
  #       :phone_allowance => 0,
  #       :medical_allowance => 0,
  #       :overtime => 0,
  #       :pph21_allowance => 0,
  #       :other_allowance_taxable => 0,
  #       :other_allowance_non_taxable => 0,
  #       :thr => 0,
  #       :commission => "",
  #       :jkk => 0,
  #       :jkm => 0,
  #       :jht_company => 0,
  #       :bpjs_company => 0,
  #       :other_expense_taxable => 0,
  #       :other_expense_non_taxable => 0,
  #       :loan => 0,
  #       :cooperative_dues => 0,
  #       :jht_employee => 0,
  #       :bpjs_employee => 0,
  #       :pph21_value => 0
  #     )
      
  #   wage_transaction.should_not be_valid
  # end
  
  # it "should allow object creation without jkk" do
  #   date = DateTime.new(2015,1,1)
  #   wage_transaction = WageTransaction.create_object(
  #       :employee_id => @employee.id,
  #       :year => date.year.to_i,
  #       :month => date.month.to_i,
  #       :basic_salary => 2200000,
  #       :seniority_allowance => 0,
  #       :functional_allowance => 0,
  #       :meal_allowance => 0,
  #       :transport_allowance => 0,
  #       :phone_allowance => 0,
  #       :medical_allowance => 0,
  #       :overtime => 0,
  #       :pph21_allowance => 0,
  #       :other_allowance_taxable => 0,
  #       :other_allowance_non_taxable => 0,
  #       :thr => 0,
  #       :commission => 0,
  #       :jkk => "",
  #       :jkm => 0,
  #       :jht_company => 0,
  #       :bpjs_company => 0,
  #       :other_expense_taxable => 0,
  #       :other_expense_non_taxable => 0,
  #       :loan => 0,
  #       :cooperative_dues => 0,
  #       :jht_employee => 0,
  #       :bpjs_employee => 0,
  #       :pph21_value => 0
  #     )
      
  #   wage_transaction.should_not be_valid
  # end
  # it "should allow object creation without jkm" do
  #   date = DateTime.new(2015,1,1)
  #   wage_transaction = WageTransaction.create_object(
  #       :employee_id => @employee.id,
  #       :year => date.year.to_i,
  #       :month => date.month.to_i,
  #       :basic_salary => 2200000,
  #       :seniority_allowance => 0,
  #       :functional_allowance => 0,
  #       :meal_allowance => 0,
  #       :transport_allowance => 0,
  #       :phone_allowance => 0,
  #       :medical_allowance => 0,
  #       :overtime => 0,
  #       :pph21_allowance => 0,
  #       :other_allowance_taxable => 0,
  #       :other_allowance_non_taxable => 0,
  #       :thr => 0,
  #       :commission => 0,
  #       :jkk => 0,
  #       :jkm => "",
  #       :jht_company => 0,
  #       :bpjs_company => 0,
  #       :other_expense_taxable => 0,
  #       :other_expense_non_taxable => 0,
  #       :loan => 0,
  #       :cooperative_dues => 0,
  #       :jht_employee => 0,
  #       :bpjs_employee => 0,
  #       :pph21_value => 0
  #     )
      
  #   wage_transaction.should_not be_valid
  # end
  
  # it "should allow object creation without jht company" do
  #   date = DateTime.new(2015,1,1)
  #   wage_transaction = WageTransaction.create_object(
  #       :employee_id => @employee.id,
  #       :year => date.year.to_i,
  #       :month => date.month.to_i,
  #       :basic_salary => 2200000,
  #       :seniority_allowance => 0,
  #       :functional_allowance => 0,
  #       :meal_allowance => 0,
  #       :transport_allowance => 0,
  #       :phone_allowance => 0,
  #       :medical_allowance => 0,
  #       :overtime => 0,
  #       :pph21_allowance => 0,
  #       :other_allowance_taxable => 0,
  #       :other_allowance_non_taxable => 0,
  #       :thr => 0,
  #       :commission => 0,
  #       :jkk => 0,
  #       :jkm => 0,
  #       :jht_company => "",
  #       :bpjs_company => 0,
  #       :other_expense_taxable => 0,
  #       :other_expense_non_taxable => 0,
  #       :loan => 0,
  #       :cooperative_dues => 0,
  #       :jht_employee => 0,
  #       :bpjs_employee => 0,
  #       :pph21_value => 0
  #     )
      
  #   wage_transaction.should_not be_valid
  # end
  
  # it "should allow object creation without bpjs company" do
  #   date = DateTime.new(2015,1,1)
  #   wage_transaction = WageTransaction.create_object(
  #       :employee_id => @employee.id,
  #       :year => date.year.to_i,
  #       :month => date.month.to_i,
  #       :basic_salary => 2200000,
  #       :seniority_allowance => 0,
  #       :functional_allowance => 0,
  #       :meal_allowance => 0,
  #       :transport_allowance => 0,
  #       :phone_allowance => 0,
  #       :medical_allowance => 0,
  #       :overtime => 0,
  #       :pph21_allowance => 0,
  #       :other_allowance_taxable => 0,
  #       :other_allowance_non_taxable => 0,
  #       :thr => 0,
  #       :commission => 0,
  #       :jkk => 0,
  #       :jkm => 0,
  #       :jht_company => 0,
  #       :bpjs_company => "",
  #       :other_expense_taxable => 0,
  #       :other_expense_non_taxable => 0,
  #       :loan => 0,
  #       :cooperative_dues => 0,
  #       :jht_employee => 0,
  #       :bpjs_employee => 0,
  #       :pph21_value => 0
  #     )
      
  #   wage_transaction.should_not be_valid
  # end
  
  # it "should allow object creation without other expense taxable" do
  #   date = DateTime.new(2015,1,1)
  #   wage_transaction = WageTransaction.create_object(
  #       :employee_id => @employee.id,
  #       :year => date.year.to_i,
  #       :month => date.month.to_i,
  #       :basic_salary => 2200000,
  #       :seniority_allowance => 0,
  #       :functional_allowance => 0,
  #       :meal_allowance => 0,
  #       :transport_allowance => 0,
  #       :phone_allowance => 0,
  #       :medical_allowance => 0,
  #       :overtime => 0,
  #       :pph21_allowance => 0,
  #       :other_allowance_taxable => 0,
  #       :other_allowance_non_taxable => 0,
  #       :thr => 0,
  #       :commission => 0,
  #       :jkk => 0,
  #       :jkm => 0,
  #       :jht_company => 0,
  #       :bpjs_company => 0,
  #       :other_expense_taxable => "",
  #       :other_expense_non_taxable => 0,
  #       :loan => 0,
  #       :cooperative_dues => 0,
  #       :jht_employee => 0,
  #       :bpjs_employee => 0,
  #       :pph21_value => 0
  #     )
      
  #   wage_transaction.should_not be_valid
  # end
  
  # it "should allow object creation without other expense non taxable" do
  #   date = DateTime.new(2015,1,1)
  #   wage_transaction = WageTransaction.create_object(
  #       :employee_id => @employee.id,
  #       :year => date.year.to_i,
  #       :month => date.month.to_i,
  #       :basic_salary => 2200000,
  #       :seniority_allowance => 0,
  #       :functional_allowance => 0,
  #       :meal_allowance => 0,
  #       :transport_allowance => 0,
  #       :phone_allowance => 0,
  #       :medical_allowance => 0,
  #       :overtime => 0,
  #       :pph21_allowance => 0,
  #       :other_allowance_taxable => 0,
  #       :other_allowance_non_taxable => 0,
  #       :thr => 0,
  #       :commission => 0,
  #       :jkk => 0,
  #       :jkm => 0,
  #       :jht_company => 0,
  #       :bpjs_company => 0,
  #       :other_expense_taxable => 0,
  #       :other_expense_non_taxable => "",
  #       :loan => 0,
  #       :cooperative_dues => 0,
  #       :jht_employee => 0,
  #       :bpjs_employee => 0,
  #       :pph21_value => 0
  #     )
      
  #   wage_transaction.should_not be_valid
  # end
  
  # it "should allow object creation without loan" do
  #   date = DateTime.new(2015,1,1)
  #   wage_transaction = WageTransaction.create_object(
  #       :employee_id => @employee.id,
  #       :year => date.year.to_i,
  #       :month => date.month.to_i,
  #       :basic_salary => 2200000,
  #       :seniority_allowance => 0,
  #       :functional_allowance => 0,
  #       :meal_allowance => 0,
  #       :transport_allowance => 0,
  #       :phone_allowance => 0,
  #       :medical_allowance => 0,
  #       :overtime => 0,
  #       :pph21_allowance => 0,
  #       :other_allowance_taxable => 0,
  #       :other_allowance_non_taxable => 0,
  #       :thr => 0,
  #       :commission => 0,
  #       :jkk => 0,
  #       :jkm => 0,
  #       :jht_company => 0,
  #       :bpjs_company => 0,
  #       :other_expense_taxable => 0,
  #       :other_expense_non_taxable => 0,
  #       :loan => "",
  #       :cooperative_dues => 0,
  #       :jht_employee => 0,
  #       :bpjs_employee => 0,
  #       :pph21_value => 0
  #     )
      
  #   wage_transaction.should_not be_valid
  # end
  
  # it "should allow object creation without cooperative_dues" do
  #   date = DateTime.new(2015,1,1)
  #   wage_transaction = WageTransaction.create_object(
  #       :employee_id => @employee.id,
  #       :year => date.year.to_i,
  #       :month => date.month.to_i,
  #       :basic_salary => 2200000,
  #       :seniority_allowance => 0,
  #       :functional_allowance => 0,
  #       :meal_allowance => 0,
  #       :transport_allowance => 0,
  #       :phone_allowance => 0,
  #       :medical_allowance => 0,
  #       :overtime => 0,
  #       :pph21_allowance => 0,
  #       :other_allowance_taxable => 0,
  #       :other_allowance_non_taxable => 0,
  #       :thr => 0,
  #       :commission => 0,
  #       :jkk => 0,
  #       :jkm => 0,
  #       :jht_company => 0,
  #       :bpjs_company => 0,
  #       :other_expense_taxable => 0,
  #       :other_expense_non_taxable => 0,
  #       :loan => 0,
  #       :cooperative_dues => "",
  #       :jht_employee => 0,
  #       :bpjs_employee => 0,
  #       :pph21_value => 0
  #     )
      
  #   wage_transaction.should_not be_valid
  # end
  
  # it "should allow object creation without jht employee" do
  #   date = DateTime.new(2015,1,1)
  #   wage_transaction = WageTransaction.create_object(
  #       :employee_id => @employee.id,
  #       :year => date.year.to_i,
  #       :month => date.month.to_i,
  #       :basic_salary => 2200000,
  #       :seniority_allowance => 0,
  #       :functional_allowance => 0,
  #       :meal_allowance => 0,
  #       :transport_allowance => 0,
  #       :phone_allowance => 0,
  #       :medical_allowance => 0,
  #       :overtime => 0,
  #       :pph21_allowance => 0,
  #       :other_allowance_taxable => 0,
  #       :other_allowance_non_taxable => 0,
  #       :thr => 0,
  #       :commission => 0,
  #       :jkk => 0,
  #       :jkm => 0,
  #       :jht_company => 0,
  #       :bpjs_company => 0,
  #       :other_expense_taxable => 0,
  #       :other_expense_non_taxable => 0,
  #       :loan => 0,
  #       :cooperative_dues => 0,
  #       :jht_employee => "",
  #       :bpjs_employee => 0,
  #       :pph21_value => 0
  #     )
      
  #   wage_transaction.should_not be_valid
  # end
  
  # it "should allow object creation without bpjs employee" do
  #   date = DateTime.new(2015,1,1)
  #   wage_transaction = WageTransaction.create_object(
  #       :employee_id => @employee.id,
  #       :year => date.year.to_i,
  #       :month => date.month.to_i,
  #       :basic_salary => 2200000,
  #       :seniority_allowance => 0,
  #       :functional_allowance => 0,
  #       :meal_allowance => 0,
  #       :transport_allowance => 0,
  #       :phone_allowance => 0,
  #       :medical_allowance => 0,
  #       :overtime => 0,
  #       :pph21_allowance => 0,
  #       :other_allowance_taxable => 0,
  #       :other_allowance_non_taxable => 0,
  #       :thr => 0,
  #       :commission => 0,
  #       :jkk => 0,
  #       :jkm => 0,
  #       :jht_company => 0,
  #       :bpjs_company => 0,
  #       :other_expense_taxable => 0,
  #       :other_expense_non_taxable => 0,
  #       :loan => 0,
  #       :cooperative_dues => 0,
  #       :jht_employee => 0,
  #       :bpjs_employee => "",
  #       :pph21_value => 0
  #     )
      
  #   wage_transaction.should_not be_valid
  # end
  
  # it "should allow object creation without pph21 value" do
  #   date = DateTime.new(2015,1,1)
  #   wage_transaction = WageTransaction.create_object(
  #       :employee_id => @employee.id,
  #       :year => date.year.to_i,
  #       :month => date.month.to_i,
  #       :basic_salary => 2200000,
  #       :seniority_allowance => 0,
  #       :functional_allowance => 0,
  #       :meal_allowance => 0,
  #       :transport_allowance => 0,
  #       :phone_allowance => 0,
  #       :medical_allowance => 0,
  #       :overtime => 0,
  #       :pph21_allowance => 0,
  #       :other_allowance_taxable => 0,
  #       :other_allowance_non_taxable => 0,
  #       :thr => 0,
  #       :commission => 0,
  #       :jkk => 0,
  #       :jkm => 0,
  #       :jht_company => 0,
  #       :bpjs_company => 0,
  #       :other_expense_taxable => 0,
  #       :other_expense_non_taxable => 0,
  #       :loan => 0,
  #       :cooperative_dues => 0,
  #       :jht_employee => 0,
  #       :bpjs_employee => 0,
  #       :pph21_value => ""
  #     )
      
  #   wage_transaction.should_not be_valid
  # end
  
  # context "has been created wage transaction" do
  #   before(:each) do
  #     @wage_transaction_1_date = DateTime.new(2015,1,1)
  #     @wage_transaction = WageTransaction.create_object(
  #         :employee_id => @employee.id,
  #         :year => @wage_transaction_1_date.year.to_i,
  #         :month => @wage_transaction_1_date.month.to_i,
  #         :basic_salary => 2200000,
  #         :seniority_allowance => 0,
  #         :functional_allowance => 0,
  #         :meal_allowance => 0,
  #         :transport_allowance => 0,
  #         :phone_allowance => 0,
  #         :medical_allowance => 0,
  #         :overtime => 0,
  #         :pph21_allowance => 0,
  #         :other_allowance_taxable => 0,
  #         :other_allowance_non_taxable => 0,
  #         :thr => 0,
  #         :commission => 0,
  #         :jkk => 0,
  #         :jkm => 0,
  #         :jht_company => 0,
  #         :bpjs_company => 0,
  #         :other_expense_taxable => 0,
  #         :other_expense_non_taxable => 0,
  #         :loan => 0,
  #         :cooperative_dues => 0,
  #         :jht_employee => 0,
  #         :bpjs_employee => 0,
  #         :pph21_value => 0
  #       )
  #   end
    
  #   it "should have 1 objects" do
  #     WageTransaction.count.should == 1
  #   end
    
  #   it "should create valid objects" do
  #     @wage_transaction.should be_valid
  #   end
    
  #   it "should be allowed to delete object" do
  #     @wage_transaction.delete_object
      
  #     @wage_transaction.persisted?.should be_falsy  # be_truthy 
      
  #     WageTransaction.count.should == 0
  #   end
  # end
end
