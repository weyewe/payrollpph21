class Office < ActiveRecord::Base
    has_many :branch_offices
    has_many :titles
    has_many :levels
    has_many :status_workings
    has_many :pph21s
    has_many :ptkps
    has_many :jamsosteks
    has_many :overtimes
    has_many :pph21_non_employees
    has_many :bpjs_percentages
    has_many :preferences
    
    validates_presence_of :code
    validates_presence_of :name
    
    validates_uniqueness_of :code
    
    #object.create_object
    def self.create_object( params ) 
        new_object = self.new
        
        new_object.code = params[:code]
        new_object.name = params[:name]
        new_object.address = params[:address]
        new_object.city = params[:city]
        new_object.state = params[:state]
        new_object.country = params[:country]
        new_object.postal_code = params[:postal_code]
        new_object.phone = params[:phone]
        new_object.fax = params[:fax]
        new_object.website = params[:website]
        new_object.email = params[:email]
        new_object.npwp = params[:npwp]
        new_object.director = params[:director]
        new_object.npwp_director = params[:npwp_director]
        
        new_object.save
        
        return new_object
    end
    
    #object.update_object
    def update_object( params ) 
        self.code = params[:code]
        self.name = params[:name]
        self.address = params[:address]
        self.city = params[:city]
        self.state = params[:state]
        self.country = params[:country]
        self.postal_code = params[:postal_code]
        self.phone = params[:phone]
        self.fax = params[:fax]
        self.website = params[:website]
        self.email = params[:email]
        self.npwp = params[:npwp]
        self.director = params[:director]
        self.npwp_director = params[:npwp_director]
        
        self.save
        
        return self 
    end
    
    #object.delete_object
    def delete_object
        # 1. jika sudah ada branch office, tidak boleh di delete
        if self.branch_offices.count != 0 
            self.errors.add(:generic_errors, "sudah ada branch_offices")
            return self 
        end
        
        # 2. jika sudah ada title, tidak boleh di delete
        if self.titles.count != 0 
            self.errors.add(:generic_errors, "sudah ada titles")
            return self 
        end
        
        # 3. jika sudah ada level, tidak boleh di delete
        if self.levels.count != 0 
            self.errors.add(:generic_errors, "sudah ada branch office")
            return self 
        end
        
        # 4. jika sudah ada status working, tidak boleh di delete
        if self.status_workings.count != 0 
            self.errors.add(:generic_errors, "sudah ada status_workings")
            return self 
        end
        
        # 5. jika sudah ada pph21, tidak boleh di delete
        if self.pph21s.count != 0 
            self.errors.add(:generic_errors, "sudah ada pph21s")
            return self 
        end
        
        # 6. jika sudah ada ptkp, tidak boleh di delete
        if self.ptkps.count != 0 
            self.errors.add(:generic_errors, "sudah ada ptkps")
            return self 
        end
        
        # 7. jika sudah ada jamsostek, tidak boleh di delete
        if self.jamsosteks.count != 0 
            self.errors.add(:generic_errors, "sudah ada jamsosteks")
            return self 
        end
        
        # 8. jika sudah ada overtime, tidak boleh di delete
        if self.overtimes.count != 0 
            self.errors.add(:generic_errors, "sudah ada overtimes")
            return self 
        end
        
        # 9. jika sudah ada bpjs_percentages, tidak boleh di delete
        if self.bpjs_percentages.count != 0 
            self.errors.add(:generic_errors, "sudah ada bpjs_percentages")
            return self 
        end
        
        # 10. jika sudah ada preference, tidak boleh di delete
        if self.preferences.count != 0 
            self.errors.add(:generic_errors, "sudah ada preference")
            return self 
        end
        
        self.destroy 
    end
end
