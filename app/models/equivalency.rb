class Equivalency < ApplicationRecord
    include PgSearch

    belongs_to :user
    
    mount_uploader :syllabus, SyllabusUploader
    
    multisearchable :against => [:foreign_name, :foreign_code, :course_name, :course_code, :course_categories]
    
    pg_search_scope :search, :against => [:foreign_name, :foreign_code, :course_name, :course_code, :course_categories], 
                             :using => [:tsearch, :trigram, :dmetaphone]

    self.per_page = 10
    
    def university
        University.find(self.foreign_university_id)
    end
end
