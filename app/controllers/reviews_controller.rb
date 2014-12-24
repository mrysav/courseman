class ReviewsController < ApplicationController
    before_filter :require_valid_user
    before_filter :require_admin_user, :except => [:new, :create]
    
    def index
        @reviews = Review.all
    end

    def new
        @review = current_user.reviews.new
        @universities = University.all.collect {|u| [u.name, u.id] }
        @locations = [] 
    end
    
    def create
        @review = current_user.reviews.create(review_params)
        
        if @review.save
            redirect_to @review
        else
            render 'new'
        end
    end
    
    private
    
    def review_params
        params.require(:review).permit(:dept, :date_sent, :date_due, 
                                       :date_received, :note, :provider, 
                                       :program_name, :program_term, 
                                       course_attributes: [:name, :code, :language, 
                                           university_attributes: [:id, :name, 
                                               locations_attributes: [:id, :city, :country]]])
    end

end
