class Course < ActiveRecord::Base
    belongs_to :university
    
    has_many :reviews
    has_many :users, through: :reviews
    has_many :umd_courses, through: :reviews
    
    def self.search(search)
        if search
            self.where('name ILIKE ?', "%#{search}%")
        else
            self.none
        end
    end
end
