class ShiftDetail < ActiveRecord::Base
    belongs_to :shift
    
    has_many :shift_allocations
    
    validates_presence_of :shift_id
    validates_presence_of :day_code
    validates_presence_of :start_time
    validates_presence_of :duration
    
    validate :valid_shift_id
    validate :duration_must_not_zero_and_less_than_24_hours
    validate :start_time_is_less_than_end_of_day
    validate :unique_day_code
    
    def valid_shift_id
        return if not shift_id.present? 
        
        object = Shift.find_by_id shift_id 
        
        if object.nil?
            self.errors.add(:shift_id, "Harus ada shift id")
            return self
        end
    end
    
    def unique_day_code
        return if not shift_id.present?
        
        past_data_list = ShiftDetail.where(
                :shift_id => self.shift_id,
                :day_code => self.day_code
            )
            
        if not self.persisted? and past_data_list.count != 0
            self.errors.add(:shift_id, "Shift id dan day code tidak boleh duplicate")
            self.errors.add(:day_code, "Shift id dan day code tidak boleh duplicate")
            return self
        elsif self.persisted? and past_data_list.count > 0 
            past_data = past_data_list.first 
            if past_data.id != self.id
                self.errors.add(:shift_id, "Shift id dan day code of children tidak boleh duplicate")
                self.errors.add(:day_code, "Shift id dan day code of children tidak boleh duplicate")
                return self 
            end
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
    
    
    def self.create_object( params )
        new_object = self.new
        
        new_object.shift_id = params[:shift_id]
        new_object.day_code = params[:day_code]
        new_object.start_time = params[:start_time]
        new_object.duration = params[:duration]
        
        new_object.save
        
        return new_object
    end
    
    def update_object( params )
        self.shift_id = params[:shift_id]
        self.day_code = params[:day_code]
        self.start_time = params[:start_time]
        self.duration = params[:duration]
       
        self.save
       
        return self
    end
    
    def delete_object
        self.destroy
    end
end
