class Shift < ActiveRecord::Base
    belongs_to :office
    has_many :shift_details
    has_many :shift_allocations   # shift.shift_allocations 
    has_many :employees, :through => :shift_allocations   # shift.employees 
    
    validates_presence_of :code
    validates_presence_of :name
    validates_presence_of :start_time
    validates_presence_of :duration
    validates_presence_of :office_id
    
    validate :valid_office_id
    validate :unique_code
    validate :duration_must_not_zero_and_less_than_24_hours
    validate :start_time_is_less_than_end_of_day
    
    def unique_code
        return if not office_id.present? 
        
        past_data_list = Shift.where(
                :office_id => self.office_id,
                :code => self.code
            )
            
        if not self.persisted? and past_data_list.count != 0
            self.errors.add(:code, "Code tidak boleh duplicate")
            return self
        elsif self.persisted? and past_data_list.count > 0 
            past_data = past_data_list.first 
            if past_data.id != self.id
                self.errors.add(:code, "Code tidak boleh duplicate")
                return self 
            end
        end
    end
    
    def valid_office_id
        return if not office_id.present? 
        
        object = Office.find_by_id office_id 
        
        if object.nil?
            self.errors.add(:office_id, "Harus ada office id")
            return self
        end
    end
    
    def duration_must_not_zero_and_less_than_24_hours
        return if not duration.present?
        
        if duration <= 0
            self.errors.add(:duration, "Tidak boleh lebih kecil dari 0 menit")
            return self
        end
        
        if duration >= 24 * 60 
            self.errors.add(:duration, "Tidak boleh lebih besar dari satu hari penuh")
            return self
        end
    end
    
    def start_time_is_less_than_end_of_day
        return if not start_time.present?
        
        if start_time < 0
            self.errors.add(:start_time, "Tidak boleh lebih kecil dari 00:00")
            return self
        end
        
        if start_time >= 24 * 60 
            self.errors.add(:start_time, "Tidak boleh lebih besar dari 23:59")
            return self
        end
    end
    
    #object.create_object
    def self.create_object( params ) 
        new_object = self.new
        
        new_object.office_id = params[:office_id]
        new_object.code = params[:code]
        new_object.name = params[:name]
        new_object.start_time = params[:start_time]
        new_object.duration = params[:duration]
        new_object.description = params[:description]
        
        new_object.save
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.office_id = params[:office_id]
        self.code = params[:code]
        self.name = params[:name]
        self.start_time = params[:start_time]
        self.duration = params[:duration]
        self.description = params[:description]
        
        self.save
        
        return self 
    end
    
    #object.deleted_object
    def delete_object
        # 1. jika sudah ada shift detail, tidak boleh di delete
        if self.shift_details.count != 0 
            self.errors.add(:generic_errors, "sudah ada shift detail")
            return self 
        end
        
        # 2. jika sudah ada employee, tidak boleh di delete
        if self.employees.count != 0 
            self.errors.add(:generic_errors, "sudah ada employee")
            return self 
        end
        
        self.destroy 
    end
end
