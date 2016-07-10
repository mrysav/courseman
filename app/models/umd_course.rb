class UmdCourse < ApplicationRecord
    belongs_to :review
    
    has_one :course, through: :review
    
end
