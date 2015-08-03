class Payroll < ActiveRecord::Base
    belongs_to :office
    
    validates_presence_of :month
    validates_presence_of :start_date
    validates_presence_of :end_date
    validates_presence_of :office_id
    
    #validates_uniqueness_of :code
    
    validate :valid_office_id
    
    def valid_office_id
        return if not office_id.present? 
        
        object = Office.find_by_id office_id 
        
        if object.nil?
            self.errors.add(:office_id, "Harus ada office id")
            return self
        end
    end
    
    #object.create_object
    def self.create_object( params ) 
        new_object = self.new
        
        new_object.office_id = params[:office_id]
        new_object.month = params[:month]
        new_object.start_date = params[:start_date]
        new_object.end_date = params[:end_date]
        
        if new_object.save
            #Get employee active
            Employee.where{
                (office_id.eq params[:office_id] ) &
                (is_not_active.eq false )         #lt less than
            }.each do |emp|
                #Get default preference
                obj_preference = Preference.where{
                    (office_id.eq emp.office_id)
                }.first
                
                current_ot_divider = obj_preference.ot_divider
                current_biaya_jabatan_percentege = obj_preference.biaya_jabatan_percentage
                current_biaya_jabatan_max = obj_preference.biaya_jabatan_max
                current_pph_non_npwp_percentage = obj_preference.pph_non_npwp_percentage
            
                #Find count presence of employee
                count_attendance = Attendance.where{
                    (employee_id.eq emp.id) &
                    ((strftime("%Y-%m-%d",date).gte params[:start_date].to_date) &
                        (strftime("%Y-%m-%d",date).lte params[:end_date].to_date)) &
                    ((status.eq ATTENDANCE_STATUS[:present]) | 
                        (status.eq ATTENDANCE_STATUS[:duty]))
                }.count
                
                #Find salary data of employee
                obj_salary = Wage.where{
                    (employee_id.eq emp.id) & 
                    (strftime("%Y-%m-%d",effective_date).lte params[:end_date].to_date)
                }.first
                
                #Get value basic salary
                if (obj_salary.is_daily_basic == false)
                    new_basic_salary = obj_salary.basic_salary * count_attendance
                else
                    new_basic_salary = obj_salary.basic_salary
                end
                
                #Get value seniority allowance
                if (obj_salary.is_daily_seniority == false)
                    new_seniority_allowance = obj_salary.seniority_allowance * count_attendance
                else
                    new_seniority_allowance = obj_salary.seniority_allowance
                end
                
                #Get value functional allowance
                if (obj_salary.is_daily_functional == false)
                    new_functional_allowance = obj_salary.functional_allowance * count_attendance
                else
                    new_functional_allowance = obj_salary.functional_allowance
                end
                
                #Get value meal allowance
                if (obj_salary.is_daily_meal == false)
                    new_meal_allowance = obj_salary.meal_allowance * count_attendance
                else
                    new_meal_allowance = obj_salary.meal_allowance
                end
                
                #Get value transport allowance
                if (obj_salary.is_daily_transport == false)
                    new_transport_allowance = obj_salary.transport_allowance * count_attendance
                else
                    new_transport_allowance = obj_salary.transport_allowance
                end
                
                #Get value communication allowance
                if (obj_salary.is_daily_communication == false)
                    new_communication_allowance = obj_salary.communication_allowance * count_attendance
                else
                    new_communication_allowance = obj_salary.communication_allowance
                end
                
                #Get value medical allowance
                if (obj_salary.is_daily_medical == false)
                    new_medical_allowance = obj_salary.medical_allowance * count_attendance
                else
                    new_medical_allowance = obj_salary.medical_allowance
                end
                
                #Get value cooperative dues
                if (obj_salary.is_cooperative_member == false)
                    new_cooperative_dues = 0
                else
                    new_cooperative_dues = obj_salary.cooperative_dues
                end
                
                #Get value overtime
                total_ot_per_month = 0
                OvertimeAllocation.where{
                    (employee_id.eq x.id) &
                    ((strftime("%Y-%m-%d",date).gte params[:start_date].to_date) &
                        (strftime("%Y-%m-%d",date).lte params[:end_date].to_date))
                }.each do |ot|
                    #Mencari total jam OT
                    if (ot.to_value < ot.from_value) #1440 adalah waktu 24 jam
                        diff_ot = (ot.to_value + 1440) - ot.from_value
                    else
                        diff_ot = ot.to_value - ot.from_value
                    end
                    diff_ot = diff_ot / 60
                    
                    total_ot_per_day = 0
                    
                    #Get multiplier overtime
                    OvertimeDetail.joins(:overtime).where{
                        (overtime.id.eq ot.overtime_id)
                    }.each do |ot_multiplier|
                        param_from = from_value
                        param_to = to_value
                        param_mutiplier = multiplier
                        
                        if (diff_ot > to_value)
                            total_ot_per_day = total_ot_per_day + (to_value * multiplier)
                        else
                            total_ot_per_day = total_ot_per_day + (diff_ot * multiplier)
                        end
                    end
                    
                    total_ot_per_month = total_ot_per_month + total_ot_per_day
                end
                
                new_overtime = total_ot_per_month * (new_basic_salary / current_ot_divider)
                
                #Get Other Allowance Taxable
                new_other_income_taxable = OtherIncome.where{
                    (employee_id.eq emp.id) & 
                    ((strftime("%Y-%m-%d",date).gte params[:start_date].to_date) &
                        (strftime("%Y-%m-%d",date).lte params[:end_date].to_date)) &
                    (is_taxable.eq true)
                }.sum("value")
                
                #Get Other Allowance Non Taxable
                new_other_income_non_taxable = OtherIncome.where{
                    (employee_id.eq emp.id) & 
                    ((strftime("%Y-%m-%d",date).gte params[:start_date].to_date) &
                        (strftime("%Y-%m-%d",date).lte params[:end_date].to_date)) &
                    (is_taxable.eq false)
                }.sum("value")
                
                #Get THR
                obj_thr = THR.where{
                    (employee_id.eq emp.id) & 
                    ((strftime("%Y-%m-%d",date).gte params[:start_date].to_date) &
                        (strftime("%Y-%m-%d",date).lte params[:end_date].to_date))
                }.first
                
                new_thr = obj_thr.value
                
                #Get Commissions
                new_commission = Commission.where{
                    (employee_id.eq emp.id) & 
                    ((strftime("%Y-%m-%d",date).gte params[:start_date].to_date) &
                        (strftime("%Y-%m-%d",date).lte params[:end_date].to_date))
                }.sum("value")
                
                #Apakah karyawan ikut jamsostek
                current_no_jamsostek = emp.no_jamsostek
                current_jamsostek_reg_date = emp.jamsostek_registered_date
                
                if (current_jamsostek_reg_date <= params[:end_date])
                    #Get JKK, JKM, JHT Employee, JHT Company
                    obj_jstk = Jamsostek.where{
                        (id.eq obj_salary.jamsostek_id)
                    }.first
                    
                    #Get JKK Value
                    new_jkk = obj_jstk.jkk_percentage * new_basic_salary
                    
                    #Get JKM Value
                    new_jkm = obj_jstk.jkm_percentage * new_basic_salary
                    
                    #Get JHT Employee Value
                    new_jht_employee = obj_jstk.jht_employee_percentage * new_basic_salary
                    
                    #Get JHT Company Value
                    new_jht_office = obj_jstk.jht_office_percentage * new_basic_salary 
                else
                    #Get JKK Value
                    new_jkk = 0
                    
                    #Get JKM Value
                    new_jkm = 0
                    
                    #Get JHT Employee Value
                    new_jht_employee = 0
                    
                    #Get JHT Company Value
                    new_jht_office = 0
                end
                
                #Apakah karyawan ikut BPJS Kesehatan
                obj_emp_bpjs = BpjsInsurance.where{
                    (employee_id.eq emp.id) &
                    (strftime("%Y-%m-%d",date).lte params[:end_date].to_date) &
                    (is_deleted.eq false)
                }.first
                
                current_bpjs_date = obj_emp_bpjs.date
                current_is_active = obj_emp_bpjs.is_active
                current_premi = obj_emp_bpjs.premi
                
                if (obj_emp_bpjs.is_active == true)
                    #Get BPJS Kesehatan Value
                    obj_bpjs = BpjsPercentage.where{
                        (office_id.eq emp.office_id)
                    }.first
                    
                    #Get BPJS Employee Value
                    new_bpjs_employee = obj_bpjs.employee_percentage * current_premi
                    
                    #Get BPJS Company Value
                    new_bpjs_office = obj_bpjs.office_percentage * current_premi
                else
                    #Get BPJS Employee Value
                    new_bpjs_employee = 0
                    
                    #Get BPJS Company Value
                    new_bpjs_office = 0
                end
                
                #Get Other Expense Taxable
                new_other_expense_taxable = OtherExpense.where{
                    (employee_id.eq emp.id) & 
                    ((strftime("%Y-%m-%d",date).gte params[:start_date].to_date) &
                        (strftime("%Y-%m-%d",date).lte params[:end_date].to_date)) &
                    (is_taxable.eq true)
                }.sum("value")
                
                #Get Other Expense Non Taxable
                new_other_expense_non_taxable = OtherExpense.where{
                    (employee_id.eq emp.id) & 
                    ((strftime("%Y-%m-%d",date).gte params[:start_date].to_date) &
                        (strftime("%Y-%m-%d",date).lte params[:end_date].to_date)) &
                    (is_taxable.eq false)
                }.sum("value")
                
                #Get Loan Value
                new_loan = 0
                LoanDetail.where{
                    (employee_id.eq emp.id) &
                    ((strftime("%Y-%m-%d",month).gte params[:start_date].to_date) &
                        (strftime("%Y-%m-%d",month).lte params[:end_date].to_date)) &
                    (is_closed.eq false)
                }.each do |loan|
                    new_loan = new_loan + loan.amount
                    
                    loan.is_paid = true
                    loan.save
                end
                
                #Apakah karyawan membayar iuran wajib koperasi
                current_is_cooperative_member = obj_salary.is_cooperative_member
                if (current_is_cooperative_member == true)
                    new_cooperative_dues = obj_salary.cooperative_dues
                else
                    new_cooperative_dues = 0
                end
                
                #Get Bruto Value
                new_bruto = (new_basic_salary + new_seniority_allowance + new_functional_allowance +
                            new_meal_allowance + new_transport_allowance + new_communication_allowance +
                            new_medical_allowance + new_jkk + new_jkm + new_jht_office + new_other_income_taxable) -
                            (new_other_expens_taxable)
                
                #Get Biaya Jabatan
                if (new_bruto * current_biaya_jabatan_percentege > current_biaya_jabatan_max)
                    new_biaya_jabatan = current_biaya_jabatan_max
                else
                    new_biaya_jabatan = new_bruto * current_biaya_jabatan_percentege
                end
                
                #Get Netto Value
                new_netto = new_bruto - new_jht_employee - new_biaya_jabatan
                
                #Get Netto Setahun
                if (params[:end_date].year > emp.start_working.year)
                    new_netto_yearly = new_netto * 12
                else
                    new_netto_yearly = new_netto * (12 - emp.start_working.month + 1)
                end
                
                #Get PTKP
                obj_taxation = WageTaxation.where{
                    (employee_id.eq emp.id) &
                    (strftime("%Y-%m-%d",effective_date).lte params[:end_date].to_date)
                }.first
                
                current_marital_status = obj_taxation.marital_status
                current_number_of_children = obj_taxation.number_of_children
                current_npwp_method = obj_taxation.tax_method
                current_npwp = obj_taxation.npwp
                current_npwp_regitered_date = obj_taxation.npwp_registered_date
                
                obj_ptkp = Ptkp.where{
                    (id.eq obj_salary.ptkp_id) &
                    (marital_status.eq current_marital_status) &
                    (number_of_children.eq current_number_of_children)
                }.first
                
                new_ptkp = obj_ptkp.value
                
                #Get PKP Value
                new_pkp = new_netto_yearly - new_ptkp + new_thr + new_commission
                new_pkp = new_pkp - (new_pkp%1000)
                
                if (new_pkp < 0)
                    new_pkp = 0
                end
                
                #Get PPh21
                total_pph = 0
                
                #Mencari Tarif PPh21
                if (current_npwp_method != 2)
                    Pph21Detail.where{
                        (pph21_id.eq obj_salary.pph21_id)
                    }.each do |pph|
                        if (pph.is_up == false) #Hingga tak terbatas (is up)
                            if (new_pkp > pph.to_value)
                                total_pph = total_pph + ((pph.percentage/100)*(pph.to_value-pph.from_value))
                                
                                new_pkp = new_pkp - (pph.to_value-pph.from_value)
                                
                                if (new_pkp < 0)
                                    new_pkp = 0
                                end
                            else
                                if (new_pkp > 0)
                                    total_pph = total_pph + (pph.percentage/100*new_pkp)
                                    
                                    new_pkp = new_pkp - (pph.to_value-pph.from_value)
                                
                                    if (new_pkp < 0)
                                        new_pkp = 0
                                    end
                                else
                                    total_pph = total_pph + 0
                                end
                            end
                        else
                            if (new_pkp > pph.from_value)
                                total_pph = total_pph + ((pph.percentage/100) * (new_pkp - pph.from_value))
                            else
                                total_pph = total_pph + 0
                            end
                        end
                    end
                else
                    Pph21Detail.where{
                        (pph21_id.eq obj_salary.pph21_id)
                    }.each do |pph|
                        new_pph_max = (pph.percentage / 100) * (pph.to_value - pph.from_value)
                        new_pph_batas_pkp = pph.to_value - ((pph.percentage / 100) * pph.to_value)
                        
                        if new_pkp < new_pph_batas_pkp
                            if (pph.from_value == 0)
                                total_pph = (new_pkp - pph.from_value) * (pph.percentage / (100 - pph.percentage)) + pph.from_value
                                new_pkp = 0
                            else
                                if (new_pkp != 0)
                                    total_pph = (new_pkp - new_pph_batas_pkp) * (pph.percentage / (100 - pph.percentage)) + new_pph_max
                                end
                            end
                        else
                            total_pph = total_pph + 0
                        end
                    end
                end
                
                #Get Pph21 Yearly
                new_pph21_yearly = total_pph
                
                #Get PPh21
                if (params[:end_date].year > emp.start_working.year)
                    new_pph21 = new_pph21_yearly / 12
                else
                    new_pph21 = new_pph21_yearly / (12 - emp.start_working.month + 1)
                end
                
                #Apakah karyawan punya npwp?
                if (current_npwp != "")
                    new_pph21_non_npwp = new_pph21 * (current_pph_non_npwp_percentage/100)
                else
                    new_pph21_non_npwp = 0
                end
                
                #Get PPh21 after check NPWP
                new_pph21 = new_pph21 + new_pph21_non_npwp
                
                #Get PPh21 Allowance
                if (current_npwp_method != 2)
                    new_pph21_allowance = 0
                else
                    new_pph21_allowance = new_pph21
                end
                
                obj_payroll = WageTransaction.where{
                    (employee_id.eq emp.id) &
                    (month.eq params[:month].strftime("%Y-%m"))
                }.first
                
                obj_payroll.destroy
                
                WageTransaction.create_object(
                    :employee_id => emp.id,
                    :month => params[:month].strftime("%Y-%m"),
                    :basic_salary => new_basic_salary,
                    :seniority_allowance => new_seniority_allowance,
                    :functional_allowance => new_functional_allowance,
                    :meal_allowance => new_meal_allowance,
                    :transport_allowance => new_transport_allowance,
                    :phone_allowance => new_communication_allowance,
                    :medical_allowance => new_medical_allowance,
                    :overtime => new_overtime,
                    :pph21_allowance => new_pph21_allowance,
                    :other_allowance_taxable => new_other_income_taxable,
                    :other_allowance_non_taxable => new_other_income_non_taxable,
                    :thr => new_thr,
                    :commission => new_commission,
                    :jkk => new_jkk,
                    :jkm => new_jkm,
                    :jht_company => new_jht_office,
                    :bpjs_company => new_bpjs_office,
                    :other_expense_taxable => new_other_expense_taxable,
                    :other_expense_non_taxable => new_other_expense_non_taxable,
                    :loan => new_loan,
                    :cooperative_dues => new_cooperative_dues,
                    :jht_employee => new_jht_employee,
                    :bpjs_employee => new_bpjs_employee,
                    :pph21_value => new_pph21
                )
            end
        end
        
        return new_object
    end
    
    #object.deleted_object
    def delete_object
        self.destroy 
    end
end
