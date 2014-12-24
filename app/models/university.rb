class University < ActiveRecord::Base
    has_many :locations
    has_many :courses
    
    accepts_nested_attributes_for :locations
    
    def self.search(search)
        if search
            self.where('name ILIKE ?', "%#{search}%")
        else
            self.all
        end
    end
end

