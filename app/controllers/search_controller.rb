class SearchController < ApplicationController
    
    def test
        
    end
    
    def index
        @courses = Course.search(params[:course])
    end
end
