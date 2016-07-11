class SearchController < ApplicationController
    require 'will_paginate/array'
    
    def index
        @reviews = PgSearch.multisearch(params[:course])
        @reviews = @reviews.select { |r| r.searchable.is_a? Review && r.searchable.status == :approved }
        @courses = @reviews.paginate(:page => params[:page], :per_page => 10)
    end

end
