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
            current_start_date = params[:start_date]
            current_end_date = params[:end_date]
            
            current_ot_divider = 0
            current_biaya_jabatan_percentege = 0
            current_biaya_jabatan_max = 0
            current_pph_non_npwp_percentage = 0
            count_attendance = 0
            
            new_basic_salary = BigDecimal("0")
            new_seniority_allowance = BigDecimal("0")
            new_functional_allowance = BigDecimal("0")
            new_meal_allowance = BigDecimal("0")
            new_transport_allowance = BigDecimal("0")
            new_communication_allowance = BigDecimal("0")
            new_medical_allowance = BigDecimal("0")
            new_cooperative_dues = BigDecimal("0")
            
            new_overtime = BigDecimal("0")
            new_other_income_taxable = BigDecimal("0")
            new_other_income_non_taxable = BigDecimal("0")
            new_thr = BigDecimal("0")
            new_commission = BigDecimal("0")
            
            current_no_jamsostek = ""
            current_jamsostek_reg_date = DateTime.now
            
            new_jkk = BigDecimal("0")
            new_jkm = BigDecimal("0")
            new_jht_employee = BigDecimal("0")
            new_jht_office = BigDecimal("0")
            new_jp_employee = BigDecimal("0")
            new_jp_office = BigDecimal("0")
            
            current_is_cooperative_member = false
            
            current_bpjs_date = DateTime.now
            current_is_active = false
            current_premi = 0
            
            new_bpjs_employee = BigDecimal("0")
            new_bpjs_office = BigDecimal("0")
            
            new_other_expense_taxable = BigDecimal("0")
            new_other_expense_non_taxable = BigDecimal("0")
            new_loan = BigDecimal("0")
            
            new_cooperative_dues = BigDecimal("0")
            
            new_ptkp = BigDecimal("0")
                         
            #Get employee active
            Employee.where{
                (office_id.eq params[:office_id] ) &
                (strftime("%Y-%m-%d",start_working).lte  params[:end_date].to_date) &         #lt less than
                ((not_active_at.eq nil) |
                    (strftime("%Y-%m-%d",not_active_at).gte params[:start_date].to_date))
            }.each do |emp|
                current_start_working = emp.start_working
                
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
                        (status.eq ATTENDANCE_STATUS[:duty])) &
                    (is_deleted.eq false)
                }.count
                
                #Find salary data of employee
                obj_salary = Wage.where{
                    (employee_id.eq emp.id) & 
                    (strftime("%Y-%m-%d",effective_date).lte params[:end_date].to_date)
                }.last
                
                if not obj_salary.nil?
                    #Get value basic salary
                    if (obj_salary.is_daily_basic == true)
                        new_basic_salary = obj_salary.basic_salary * count_attendance
                    else
                        if (emp.start_working > current_start_date)
                            tot_day = (current_end_date.to_date - emp.start_working.to_date).to_i

                            new_basic_salary = (tot_day / current_end_date.end_of_month.day.to_f) * obj_salary.basic_salary
                        else
                            if not emp.not_active_at.nil?
                                if emp.not_active_at.to_date > current_start_date
                                    tot_day = (emp.not_active_at.to_date - params[:start_date].to_date).to_i
                                    
                                    new_basic_salary = (tot_day / current_end_date.end_of_month.days.to_f) * obj_salary.basic_salary
                                else
                                    new_basic_salary = 0
                                end
                            else
                                new_basic_salary = obj_salary.basic_salary
                            end
                        end
                    end
                    new_basic_salary = new_basic_salary.round
                    
                    #Get value seniority allowance
                    if (obj_salary.is_daily_seniority == true)
                        new_seniority_allowance = obj_salary.seniority_allowance * count_attendance
                    else
                        if (emp.start_working > current_start_date)
                            tot_day = (current_end_date.to_date - emp.start_working.to_date).to_i

                            new_seniority_allowance = (tot_day / current_end_date.end_of_month.day.to_f) * obj_salary.seniority_allowance
                        else
                            if not emp.not_active_at.nil?
                                if emp.not_active_at.to_date > current_start_date
                                    tot_day = (emp.not_active_at.to_date - params[:start_date].to_date).to_i
                                    
                                    new_seniority_allowance = (tot_day / current_end_date.end_of_month.days.to_f) * obj_salary.seniority_allowance
                                else
                                    new_seniority_allowance = 0
                                end
                            else
                                new_seniority_allowance = obj_salary.seniority_allowance
                            end
                        end
                    end
                    new_seniority_allowance = new_seniority_allowance.round
                    
                    #Get value functional allowance
                    if (obj_salary.is_daily_functional == true)
                        new_functional_allowance = obj_salary.functional_allowance * count_attendance
                    else
                        if (emp.start_working > current_start_date)
                            tot_day = (current_end_date.to_date - emp.start_working.to_date).to_i

                            new_functional_allowance = (tot_day / current_end_date.end_of_month.day.to_f) * obj_salary.functional_allowance
                        else
                            if not emp.not_active_at.nil?
                                if emp.not_active_at.to_date > current_start_date
                                    tot_day = (emp.not_active_at.to_date - params[:start_date].to_date).to_i
                                    
                                    new_functional_allowance = (tot_day / current_end_date.end_of_month.days.to_f) * obj_salary.functional_allowance
                                else
                                    new_functional_allowance = 0
                                end
                            else
                                new_functional_allowance = obj_salary.functional_allowance
                            end
                        end
                    end
                    new_functional_allowance = new_functional_allowance.round
                    
                    #Get value meal allowance
                    if (obj_salary.is_daily_meal == true)
                        new_meal_allowance = obj_salary.meal_allowance * count_attendance
                    else
                        if (emp.start_working > current_start_date)
                            tot_day = (current_end_date.to_date - emp.start_working.to_date).to_i

                            new_meal_allowance = (tot_day / current_end_date.end_of_month.day.to_f) * obj_salary.meal_allowance
                        else
                            if not emp.not_active_at.nil?
                                if emp.not_active_at.to_date > current_start_date
                                    tot_day = (emp.not_active_at.to_date - params[:start_date].to_date).to_i
                                    
                                    new_meal_allowance = (tot_day / current_end_date.end_of_month.days.to_f) * obj_salary.meal_allowance
                                else
                                    new_meal_allowance = 0
                                end
                            else
                                new_meal_allowance = obj_salary.meal_allowance
                            end
                        end
                    end
                    new_meal_allowance = new_meal_allowance.round
                    
                    #Get value transport allowance
                    if (obj_salary.is_daily_transport == true)
                        new_transport_allowance = obj_salary.transport_allowance * count_attendance
                    else
                        if (emp.start_working > current_start_date)
                            tot_day = (current_end_date.to_date - emp.start_working.to_date).to_i

                            new_transport_allowance = (tot_day / current_end_date.end_of_month.day.to_f) * obj_salary.transport_allowance
                        else
                            if not emp.not_active_at.nil?
                                if emp.not_active_at.to_date > current_start_date
                                    tot_day = (emp.not_active_at.to_date - params[:start_date].to_date).to_i
                                    
                                    new_transport_allowance = (tot_day / current_end_date.end_of_month.days.to_f) * obj_salary.transport_allowance
                                else
                                    new_transport_allowance = 0
                                end
                            else
                                new_transport_allowance = obj_salary.transport_allowance
                            end
                        end
                    end
                    new_transport_allowance = new_transport_allowance.round
                    
                    #Get value communication allowance
                    if (obj_salary.is_daily_communication == true)
                        new_communication_allowance = obj_salary.communication_allowance * count_attendance
                    else
                        if (emp.start_working > current_start_date)
                            tot_day = (current_end_date.to_date - emp.start_working.to_date).to_i

                            new_communication_allowance = (tot_day / current_end_date.end_of_month.day.to_f) * obj_salary.communication_allowance
                        else
                            if not emp.not_active_at.nil?
                                if emp.not_active_at.to_date > current_start_date
                                    tot_day = (emp.not_active_at.to_date - params[:start_date].to_date).to_i
                                    
                                    new_communication_allowance = (tot_day / current_end_date.end_of_month.days.to_f) * obj_salary.communication_allowance
                                else
                                    new_communication_allowance = 0
                                end
                            else
                                new_communication_allowance = obj_salary.communication_allowance
                            end
                        end
                    end
                    new_communication_allowance = new_communication_allowance.round
                    
                    #Get value medical allowance
                    if (obj_salary.is_daily_medical == true)
                        new_medical_allowance = obj_salary.medical_allowance * count_attendance
                    else
                        if (emp.start_working > current_start_date)
                            tot_day = (current_end_date.to_date - emp.start_working.to_date).to_i

                            new_medical_allowance = (tot_day / current_end_date.end_of_month.day.to_f) * obj_salary.medical_allowance
                        else
                            if not emp.not_active_at.nil?
                                if emp.not_active_at.to_date > current_start_date
                                    tot_day = (emp.not_active_at.to_date - params[:start_date].to_date).to_i
                                    
                                    new_medical_allowance = (tot_day / current_end_date.end_of_month.days.to_f) * obj_salary.medical_allowance
                                else
                                    new_medical_allowance = 0
                                end
                            else
                                new_medical_allowance = obj_salary.medical_allowance
                            end
                        end
                    end
                    new_medical_allowance = new_medical_allowance.round
                    
                    #Get value cooperative dues
                    if (obj_salary.is_cooperative_member == false)
                        new_cooperative_dues = 0
                    else
                        new_cooperative_dues = obj_salary.cooperative_dues
                    end
                end
                
                #Get value overtime
                total_ot_per_month = 0
                
                OvertimeAllocation.where{
                    (employee_id.eq emp.id) &
                    ((strftime("%Y-%m-%d",date).gte params[:start_date].to_date) &
                        (strftime("%Y-%m-%d",date).lte params[:end_date].to_date)) &
                    (is_approved.eq true) & 
                    (is_deleted.eq false)
                }.each do |ot|
                    current_overtime_id = ot.overtime_id
                    #Mencari total jam OT
                    if (ot.end_time < ot.start_time) #1440 adalah waktu 24 jam
                        diff_ot = (ot.end_time + 1440) - ot.start_time
                    else
                        diff_ot = ot.end_time - ot.start_time
                    end
                    diff_ot = diff_ot / 60
                    
                    total_ot_per_day = 0
                    
                    #Get multiplier overtime
                    OvertimeDetail.joins(:overtime).where{
                        (overtime.id.eq current_overtime_id)
                    }.each do |ot_multiplier|
                        param_from = ot_multiplier.from_value
                        param_to = ot_multiplier.to_value
                        param_multiplier = ot_multiplier.multiplier
                        
                        if (diff_ot > param_to)
                            total_ot_per_day = total_ot_per_day + ((param_to - param_from) * param_multiplier)
                        else
                            if (diff_ot > 0)
                                total_ot_per_day = total_ot_per_day + ((diff_ot - param_from) * param_multiplier)
                                
                                diff_ot = 0
                            else
                                total_ot_per_day = total_ot_per_day + 0
                            end
                        end
                    end
                    
                    total_ot_per_month = total_ot_per_month + total_ot_per_day
                end
                new_overtime = total_ot_per_month * (new_basic_salary / current_ot_divider)
                new_overtime = new_overtime.round
                
                #Get Other Allowance Taxable
                new_other_income_taxable = OtherIncome.where{
                    (employee_id.eq emp.id) & 
                    ((strftime("%Y-%m-%d",date).gte params[:start_date].to_date) &
                        (strftime("%Y-%m-%d",date).lte params[:end_date].to_date)) &
                    (is_taxable.eq true) & 
                    (is_deleted.eq false)
                }.sum("value")
                
                #Get Other Allowance Non Taxable
                new_other_income_non_taxable = OtherIncome.where{
                    (employee_id.eq emp.id) & 
                    ((strftime("%Y-%m-%d",date).gte params[:start_date].to_date) &
                        (strftime("%Y-%m-%d",date).lte params[:end_date].to_date)) &
                    (is_taxable.eq false) & 
                    (is_deleted.eq false)
                }.sum("value")
                
                #Get THR
                obj_thr = Thr.where{
                    (employee_id.eq emp.id) & 
                    ((strftime("%Y-%m-%d",date).gte params[:start_date].to_date) &
                        (strftime("%Y-%m-%d",date).lte params[:end_date].to_date)) & 
                    (is_deleted.eq false)
                }.first
                
                if not obj_thr.nil?
                    new_thr = obj_thr.value
                end
                
                #Get Commissions
                new_commission = Commission.where{
                    (employee_id.eq emp.id) & 
                    ((strftime("%Y-%m-%d",date).gte params[:start_date].to_date) &
                        (strftime("%Y-%m-%d",date).lte params[:end_date].to_date)) & 
                    (is_deleted.eq false)
                }.sum("value")
                
                if not emp.no_jamsostek.nil?
                    #Apakah karyawan ikut jamsostek
                    current_no_jamsostek = emp.no_jamsostek
                    current_jamsostek_reg_date = emp.jamsostek_registered_date
                end 
                
                if current_no_jamsostek != ""
                    if (current_jamsostek_reg_date <= params[:end_date])
                        #Get JKK, JKM, JHT Employee, JHT Company
                        obj_jstk = Jamsostek.where{
                            (id.eq obj_salary.jamsostek_id)
                        }.first
                        
                        #Get JKK Value
                        new_jkk = (obj_jstk.jkk_percentage / 100) * new_basic_salary
                        new_jkk = new_jkk.round
                        
                        #Get JKM Value
                        new_jkm = (obj_jstk.jkm_percentage / 100) * new_basic_salary
                        new_jkm = new_jkm.round
                        
                        #Get JHT Employee Value
                        new_jht_employee = (obj_jstk.jht_employee_percentage / 100) * new_basic_salary
                        new_jht_employee = new_jht_employee.round
                        
                        #Get JHT Company Value
                        new_jht_office = (obj_jstk.jht_office_percentage / 100) * new_basic_salary
                        new_jht_office = new_jht_office.round
                        
                        #Get JP Employee Value
                        if (new_basic_salary >= obj_jstk.jp_maximum_salary)
                            new_jp_employee = (obj_jstk.jp_employee_percentage / 100) * obj_jstk.jp_maximum_salary
                        else
                            new_jp_employee = (obj_jstk.jp_employee_percentage / 100) * new_basic_salary
                        end
                        new_jp_employee = new_jp_employee.round
                        
                        #Get JP Company Value
                        if (new_basic_salary >= obj_jstk.jp_maximum_salary)
                            new_jp_office = (obj_jstk.jp_office_percentage / 100) * obj_jstk.jp_maximum_salary
                        else
                            new_jp_office = (obj_jstk.jp_office_percentage / 100) * new_basic_salary
                        end
                        new_jp_office = new_jp_office.round
                    else
                        #Get JKK Value
                        new_jkk = 0
                        
                        #Get JKM Value
                        new_jkm = 0
                        
                        #Get JHT Employee Value
                        new_jht_employee = 0
                        
                        #Get JHT Company Value
                        new_jht_office = 0
                        
                        #Get JP Employee Value
                        new_jp_employee = 0
                        
                        #Get JP Company Value
                        new_jp_office = 0
                    end
                else
                    #Get JKK Value
                    new_jkk = 0
                    
                    #Get JKM Value
                    new_jkm = 0
                    
                    #Get JHT Employee Value
                    new_jht_employee = 0
                    
                    #Get JHT Company Value
                    new_jht_office = 0
                    
                    #Get JP Employee Value
                    new_jp_employee = 0
                    
                    #Get JP Company Value
                    new_jp_office = 0
                end
                
                #Apakah karyawan ikut BPJS Kesehatan
                obj_emp_bpjs = BpjsInsurance.where{
                    (employee_id.eq emp.id) &
                    (strftime("%Y-%m-%d",date).lte params[:end_date].to_date) &
                    (is_deleted.eq false)
                }.last
                
                if not obj_emp_bpjs.nil?
                    current_bpjs_date = obj_emp_bpjs.date
                    current_is_active = obj_emp_bpjs.is_active
                    current_premi = obj_emp_bpjs.premi
                end
                
                if (obj_emp_bpjs.is_active == true)
                    #Get BPJS Kesehatan Value
                    obj_bpjs = BpjsPercentage.where{
                        (office_id.eq emp.office_id)
                    }.first
                    
                    #Get BPJS Employee Value
                    new_bpjs_employee = (obj_bpjs.employee_percentage / 100) * current_premi
                    new_bpjs_employee = new_bpjs_employee.round
                    
                    #Get BPJS Company Value
                    new_bpjs_office = (obj_bpjs.office_percentage / 100) * current_premi
                    new_bpjs_office = new_bpjs_office.round
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
                    (is_taxable.eq true) & 
                    (is_deleted.eq false)
                }.sum("value")
                
                #Get Other Expense Non Taxable
                new_other_expense_non_taxable = OtherExpense.where{
                    (employee_id.eq emp.id) & 
                    ((strftime("%Y-%m-%d",date).gte params[:start_date].to_date) &
                        (strftime("%Y-%m-%d",date).lte params[:end_date].to_date)) &
                    (is_taxable.eq false) & 
                    (is_deleted.eq false)
                }.sum("value")
                
                #Get Loan Value
                new_loan = 0
                LoanDetail.joins(:loan).where{
                    (loan.employee_id.eq emp.id) &
                    ((strftime("%Y-%m-%d",month).gte params[:start_date].to_date) &
                        (strftime("%Y-%m-%d",month).lte params[:end_date].to_date)) &
                    (is_closed.eq false) & 
                    (is_deleted.eq false)
                }.each do |loan|
                    new_loan = new_loan + loan.amount
                    
                    loan.is_paid = true
                    loan.save
                end
                
                if not obj_salary.nil?
                    #Apakah karyawan membayar iuran wajib koperasi
                    current_is_cooperative_member = obj_salary.is_cooperative_member
                    if (current_is_cooperative_member == true)
                        new_cooperative_dues = obj_salary.cooperative_dues
                    else
                        new_cooperative_dues = 0
                    end
                end
                
                #Get Bruto Value
                new_bruto = (new_basic_salary + new_seniority_allowance + new_functional_allowance +
                            new_meal_allowance + new_transport_allowance + new_communication_allowance +
                            new_medical_allowance + new_jkk + new_jkm + new_bpjs_office + 
                            new_other_income_taxable + new_overtime) -
                            (new_other_expense_taxable)
                
                #Get Biaya Jabatan
                if (new_bruto * (current_biaya_jabatan_percentege / 100) > current_biaya_jabatan_max)
                    new_biaya_jabatan = current_biaya_jabatan_max
                else
                    new_biaya_jabatan = new_bruto * (current_biaya_jabatan_percentege / 100)
                end
                
                #Get Netto Value
                new_netto = new_bruto - new_jht_employee - new_biaya_jabatan - new_jp_employee
                
                #Get Netto Setahun
                if (params[:end_date].year > emp.start_working.year)
                    new_netto_yearly = new_netto * 12
                else
                    new_netto_yearly = new_netto * (12 - emp.start_working.month + 1)
                end
                new_netto_yearly = new_netto_yearly.round
                
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
                
                obj_ptkp = PtkpDetail.joins(:ptkp).where{
                    (ptkp.id.eq obj_salary.ptkp_id) &
                    (marital_status.eq current_marital_status) &
                    (number_of_children.eq current_number_of_children)
                }.first
                
                if not obj_ptkp.nil?
                    new_ptkp = obj_ptkp.value
                end
                
                #Get PKP Value
                new_pkp = new_netto_yearly - new_ptkp + new_thr + new_commission
                new_pkp = new_pkp - (new_pkp%1000)
                
                if (new_pkp < 0)
                    new_pkp = 0
                end
                
                #Get PPh21
                total_pph = 0
                new_pkp_calculate = new_pkp
                
                #Mencari Tarif PPh21
                if (current_npwp_method != 3)
                    Pph21Detail.where{
                        (pph21_id.eq obj_salary.pph21_id)
                    }.each do |pph|
                        if (pph.is_up == false) #Hingga tak terbatas (is up)
                            if (new_pkp_calculate > pph.to_value)
                                total_pph = total_pph + ((pph.percentage/100)*(pph.to_value-pph.from_value))
                                
                                new_pkp_calculate = new_pkp_calculate - (pph.to_value-pph.from_value)
                                
                                if (new_pkp_calculate < 0)
                                    new_pkp_calculate = 0
                                end
                            else
                                if (new_pkp_calculate > 0)
                                    total_pph = total_pph + (pph.percentage/100*new_pkp_calculate)
                                    
                                    new_pkp_calculate = new_pkp_calculate - (pph.to_value-pph.from_value)
                                
                                    if (new_pkp_calculate < 0)
                                        new_pkp_calculate = 0
                                    end
                                else
                                    total_pph = total_pph + 0
                                end
                            end
                        else
                            if (new_pkp_calculate > pph.from_value)
                                total_pph = total_pph + ((pph.percentage/100) * (new_pkp_calculate - pph.from_value))
                            else
                                total_pph = total_pph + 0
                            end
                        end
                    end
                else
                    new_pph_max = 0
                    
                    Pph21Detail.where{
                        (pph21_id.eq obj_salary.pph21_id)
                    }.each do |pph|
                        new_pph_max = (pph.percentage / 100) * (pph.to_value - pph.from_value) + new_pph_max
                        new_pph_batas_pkp = pph.to_value - ((pph.percentage / 100) * pph.to_value)
                        
                        if new_pkp_calculate < new_pph_batas_pkp
                            if (pph.from_value == 0)
                                total_pph = (new_pkp_calculate - pph.from_value) * (pph.percentage / (100 - pph.percentage)) + pph.from_value
                                new_pkp_calculate = 0
                            else
                                if (new_pkp_calculate != 0)
                                    total_pph = (new_pkp_calculate - new_pph_batas_pkp) * (pph.percentage / (100 - pph.percentage)) + new_pph_max
                                end
                            end
                        else
                            total_pph = total_pph + 0
                        end
                    end
                end
                
                #Get Pph21 Yearly
                new_pph21_yearly = total_pph
                new_pph21_yearly = new_pph21_yearly.round
                
                #Get PPh21
                if (current_npwp_method != 2)
                    if (params[:end_date].year > emp.start_working.year)
                        new_pph21 = new_pph21_yearly / 12
                    else
                        new_pph21 = new_pph21_yearly / (12 - emp.start_working.month + 1)
                    end
                    new_pph21 = new_pph21.round
                else
                    new_pph21 = 0
                end
                
                #Apakah karyawan punya npwp?
                if (current_npwp != "")
                    new_pph21_non_npwp = new_pph21 * (current_pph_non_npwp_percentage/100)
                else
                    new_pph21_non_npwp = 0
                end
                new_pph21_non_npwp = new_pph21_non_npwp.round
                
                # #Get PPh21 after check NPWP
                # new_pph21 = new_pph21 + new_pph21_non_npwp
                
                #Get PPh21 Allowance
                if (current_npwp_method != 3)
                    new_pph21_allowance = 0
                else
                    new_pph21_allowance = new_pph21 + new_pph21_non_npwp
                end
                
                #Get Sisa Gaji
                new_sisa_gaji = new_bruto - new_jkk - new_jkm - new_bpjs_office -
                                new_loan - new_other_expense_non_taxable - 
                                new_cooperative_dues - new_jht_employee - new_jp_employee -
                                new_bpjs_employee - new_pph21 - new_pph21_non_npwp + 
                                new_other_income_non_taxable + new_pph21_allowance
                
                new_sisa_gaji = new_sisa_gaji.round
                                
                
                obj_payroll = WageTransaction.where{
                    (employee_id.eq emp.id) &
                    (year.eq params[:month].year) &
                    (month.eq params[:month].month)
                }.first
                
                if not obj_payroll.nil?
                    obj_payroll.destroy
                end
                
                WageTransaction.create_object(
                    :employee_id => emp.id,
                    :year => params[:month].year.to_i,
                    :month => params[:month].month.to_i,
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
                    :jp_company => new_jp_office,
                    :bpjs_company => new_bpjs_office,
                    :other_expense_taxable => new_other_expense_taxable,
                    :other_expense_non_taxable => new_other_expense_non_taxable,
                    :loan => new_loan,
                    :cooperative_dues => new_cooperative_dues,
                    :jht_employee => new_jht_employee,
                    :jp_employee => new_jp_employee,
                    :bpjs_employee => new_bpjs_employee,
                    :bruto => new_bruto,
                    :biaya_jabatan => new_biaya_jabatan,
                    :netto => new_netto,
                    :netto_yearly => new_netto_yearly,
                    :ptkp => new_ptkp,
                    :pkp => new_pkp,
                    :pph_yearly => new_pph21_yearly,
                    :pph21_value => new_pph21,
                    :pph21_non_npwp => new_pph21_non_npwp,
                    :sisa_gaji => new_sisa_gaji
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
