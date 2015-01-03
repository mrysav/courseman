class ReviewsController < ApplicationController
    before_filter :require_valid_user
    before_filter :require_admin_user, :except => [:new, :create]
    
    def index
        @reviews = Review.all
    end

    def new
        @review = current_user.reviews.new
        @universities = University.all.collect {|u| [(u.name || '(no name)') + '  (' + (u.city || '(no city)') + ', ' + (u.country || '(no country)') + ')', u.id] }
        @universities.sort! { |x,y| x[0] <=> y[0] }
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
        params.require(:review).permit(:id, :dept, :date_sent, :date_due, 
                                       :date_received, :note, :program_sponsor, 
                                       :program_name, :program_term, 
                                       course_attributes: [:id, :name, :code, :language, :university_id,
                                           university_attributes: [:id, :name, :city, :country]])
    end

end
