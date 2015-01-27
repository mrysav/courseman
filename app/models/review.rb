class Review < ActiveRecord::Base
    include PgSearch

    belongs_to :user
    belongs_to :course
    
    has_one :university, through: :course
    has_one :umd_course
    
    accepts_nested_attributes_for :course
    accepts_nested_attributes_for :umd_course

    pg_search_scope :full_search, :associated_against => { :course => [:name, :code],
                                                           :umd_course => [:name, :lib_eds, :designator, :code],
                                                           :university => [:name, :city, :country] },
                                  :using => [:tsearch, :trigram]


    self.per_page = 10
end
