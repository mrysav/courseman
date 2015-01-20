class Course < ActiveRecord::Base
    include PgSearch
    
    has_attached_file :syllabus
    validates_attachment_content_type :syllabus, :content_type => ["image/jpg", "image/jpeg", "image/png", "application/pdf", "application/zip"]
    
    belongs_to :university
    
    has_one :review
    has_one :umd_course, through: :review
    
    pg_search_scope :full_search, :against => [:name, :code], 
    :associated_against => { :university => [:name, :city, :country], 
                             :umd_course => [:name, :lib_eds, :designator, :code] },
    :using => [:tsearch, :trigram]
                        
    def approved?
        self.review != nil && self.review.status == 'approved'
    end
end
