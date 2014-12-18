class Course < ActiveRecord::Base
    belongs_to :university
    has_many :reviews
    has_many :users, through: :reviews
    has_many :umdcourses
end
