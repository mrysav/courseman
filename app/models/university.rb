class University < ApplicationRecord
    include PgSearch
    
    multisearchable :against => [:name, :city, :country]
    
    def reviews(status)
        Review.where(foreign_university_id: self.id, status: (status || :approved))
    end
end

