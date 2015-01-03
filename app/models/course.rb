class Course < ActiveRecord::Base
    belongs_to :university
    
    has_many :reviews
    has_many :users, through: :reviews
    has_many :umd_courses, through: :reviews
    
    accepts_nested_attributes_for :university
    
    def self.search(search)
        if search
            self.where('name ILIKE ?', "%#{search}%")
        else
            self.none
        end
    end
end
