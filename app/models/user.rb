class User < ApplicationRecord
    has_many :equivalencies
    
    def incomplete?
        self.student_id.blank? || 
        self.collegiate_unit.blank? || 
        self.major.blank? || 
        self.minor.blank?
    end
    
    def self.create_with_omniauth(auth)
      create! do |user|
        user.provider = auth["provider"]
        user.uid = auth["uid"]
        user.name = auth["info"]["name"]
        user.email = auth["info"]["email"]
        user.image = auth["info"]["image"]
      end
    end
    
end
