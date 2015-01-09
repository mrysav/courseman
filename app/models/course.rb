class Course < ActiveRecord::Base
    include PgSearch
    
    belongs_to :university
    
    has_one :review
    has_one :umd_course, through: :review
    
    pg_search_scope :full_search, :against => [:name, :code],
                                  :associated_against => { :university => [:name, :city, :country] }
end
