class SearchController < ApplicationController
    
    def test
        
    end
    
    def index
        @courses = Course.full_search(params[:course]).to_a
        @courses.keep_if { |c| c.approved? }
        
        @p = params[:p].to_i || 0
        
        if @p < 0
            redirect_to search_path(:course => params[:course], :p => 0)
        end
        
        if @courses.count > 10 && @p > @courses.count - 10
            redirect_to search_path(:course => params[:course], :p => @courses.count - 10)
        end
        
        @p_max = @courses.count
        
        @courses = @courses[@p..@p+9]
    end

end
