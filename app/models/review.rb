class Review < ActiveRecord::Base
    belongs_to :user
    belongs_to :course
    
    has_one :university, through: :course
    has_one :umd_course
    
    accepts_nested_attributes_for :course, :umd_course
end
