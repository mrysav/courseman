class Review < ApplicationRecord
    include PgSearch

    belongs_to :user
    
    multisearchable :against => [:foreign_name, :foreign_code, :course_name, :course_code, :course_categories]

    self.per_page = 10
    
    def university
        University.find(self.foreign_university_id)
    end
end
