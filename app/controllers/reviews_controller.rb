class ReviewsController < ApplicationController
    before_filter :require_valid_user
    before_filter :require_admin_user, :except => :new
    
    def index
        @reviews = Review.all
    end

    def new
        @review = Review.new
    end

end
