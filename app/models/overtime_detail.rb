class OvertimeDetail < ActiveRecord::Base
    belongs_to :overtime
    
    validates_presence_of :multiplier
    validates_presence_of :from_value
    validates_presence_of :to_value
    validates_presence_of :overtime_id
    
    validate :valid_overtime_id
    validate :unique_multiplier
    
    def valid_overtime_id
        return if not overtime_id.present? 
        
        object = Overtime.find_by_id overtime_id 
        
        if object.nil?
            self.errors.add(:overtime_id, "Harus ada overtime id")
            return self
        end
    end
    
    def unique_multiplier
        return if not overtime_id.present? 
        
        past_data_list = OvertimeDetail.where(
                :overtime_id => self.overtime_id,
                :multiplier => self.multiplier
            )
            
        if not self.persisted? and past_data_list.count != 0
            self.errors.add(:multiplier, "Multiplier tidak boleh duplicate")
            return self
        elsif self.persisted? and past_data_list.count > 0 
            past_data = past_data_list.first 
            if past_data.id != self.id
                self.errors.add(:multiplier, "Multiplier tidak boleh duplicate")
                return self 
            end
        end
    end
    
    #object.create_object
    def self.create_object( params ) 
        new_object = self.new
        
        new_object.overtime_id = params[:overtime_id]
        new_object.from_value = params[:from_value]
        new_object.to_value = params[:to_value]
        new_object.multiplier = params[:multiplier]
        new_object.description = params[:description]
        
        new_object.save
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.overtime_id = params[:overtime_id]
        self.from_value = params[:from_value]
        self.to_value = params[:to_value]
        self.multiplier = params[:multiplier]
        self.description = params[:description]
        
        self.save
        
        return self 
    end
    
    #object.deleted_object
    def delete_object
        self.destroy 
    end
end
