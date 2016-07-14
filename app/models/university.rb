class University < ApplicationRecord
    include PgSearch
    
    multisearchable :against => [:name, :city, :country]
    
    def equivalencies(status)
        Equivalency.where(foreign_university_id: self.id, status: (status || :approved))
    end
    
    def self.get_alphabetized_list
        universities = University.all.collect {|u| [(u.name || '(no name)') + '  (' + (u.city || '(no city)') + ', ' + (u.country || '(no country)') + ')', u.id] }
        universities.sort! { |x,y| x[0] <=> y[0] }
        universities
    end
end

