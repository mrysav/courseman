class SearchController < ApplicationController
    require 'will_paginate/array'
    
    def index
        # Search the database for equivalencies and universities that match the search terms
        @results = PgSearch.multisearch(params[:course])
        # Filter the results for universities approved equivalencies
        @results = @results.select { |r| !r.searchable.is_a? Review || (r.searchable.is_a? Review && r.searchable.status == :approved) }
        # Return the paginated results
        @results = @results.paginate(:page => params[:page], :per_page => 10)
    end

end
