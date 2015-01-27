class SearchController < ApplicationController
    
    def test
        
    end
    
    def index
        @courses = Course.approved.full_search(params[:course]).paginate(:page => params[:page], :per_page => 10)
    end

end
