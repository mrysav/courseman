class SearchController < ApplicationController
    
    def test
        
    end
    
    def index
        @courses = Course.full_search(params[:course])
    end

end
