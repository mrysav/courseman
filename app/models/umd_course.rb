class UmdCourse < ActiveRecord::Base
    belongs_to :review
    
    has_one :course, through: :review
end
