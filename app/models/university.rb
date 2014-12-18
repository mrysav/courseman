class University < ActiveRecord::Base
    has_many :locations
    has_many :courses
end

