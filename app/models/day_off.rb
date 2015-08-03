class DayOff < ActiveRecord::Base
    belongs_to :office
    
    validates_presence_of :date
    validates_presence_of :overtime_id
    validates_presence_of :office_id
    
    #validates_uniqueness_of :code
    
    validate :valid_office_id
    validate :valid_overtime_id
    validate :unique_date
    
    def unique_date
        return if not office_id.present? 
        
        past_data_list = DayOff.where(
                :office_id => self.office_id,
                :date => self.date
            )
            
        if not self.persisted? and past_data_list.count != 0
            self.errors.add(:date, "Date tidak boleh duplicate")
            return self
        elsif self.persisted? and past_data_list.count > 0 
            past_data = past_data_list.first 
            if past_data.id != self.id
                self.errors.add(:date, "Date tidak boleh duplicate")
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
    
    def valid_overtime_id
        return if not overtime_id.present? 
        
        object = Overtime.find_by_id overtime_id 
        
        if object.nil?
            self.errors.add(:overtime_id, "Harus ada overtime id")
            return self
        end
    end
    
    #object.create_object
    def self.create_object( params ) 
        new_object = self.new
        
        new_object.office_id = params[:office_id]
        new_object.overtime_id = params[:overtime_id]
        new_object.date = params[:date]
        new_object.description = params[:description]
        
        new_object.save
        
        return new_object
    end
    
    # object.update_object 
    def update_object( params )
        self.office_id = params[:office_id]
        self.overtime_id = params[:overtime_id]
        self.date = params[:date]
        self.description = params[:description]
        
        self.save
        
        return self 
    end
    
    #object.deleted_object
    def delete_object
        self.destroy 
    end
end
