class AjaxController < ApplicationController
    def university_locations
        @locations = Location.find_by_university_id(params[:university_id])
        respond_to do |format|
          format.js
        end
    end
end
