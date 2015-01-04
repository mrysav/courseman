class Course < ActiveRecord::Base
    belongs_to :university
    
    has_one :review
    has_one :umd_course, through: :review
    
    def self.search(search)
        if search
            self.where('name ILIKE ?', "%#{search}%")
        else
            self.none
        end
    end
end
