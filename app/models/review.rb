class Review < ActiveRecord::Base
    belongs_to :user
    belongs_to :course
    
    accepts_nested_attributes_for :course
end
