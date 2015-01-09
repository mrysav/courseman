class SearchController < ApplicationController
    
    def test
        
    end
    
    def index
        @courses = Course.full_search(params[:course]).to_a
        @courses.keep_if { |c| c.approved? }
    end

end
