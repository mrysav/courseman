class ReviewsController < ApplicationController
    before_filter :require_valid_user
    before_filter :require_admin_user, :except => [:new, :create, :user]
    
    #TODO: Lots of the code in [#new, #edit] and [#create, #update] and [#index, #user] can be merged somehow
    
    def index
        
        case params[:status]
        when 'approved'
            @reviews = Review.where(:status => :approved)
        when 'pending'
            @reviews = Review.where(:status => :pending)
        when 'sent'
            @reviews = Review.where(:status => [:sent, :resent])
        else
            @reviews = Review.where(:status => :pending)
        end
        
        @p = params[:p].to_i || 0
        
        if @p < 0
            redirect_to reviews_path(:status => params[:status], :p => 0)
        end
        
        if @reviews.count > 10 && @p > @reviews.count - 10
            redirect_to reviews_path(:status => params[:status], :p => @reviews.count - 10)
        end
        
        @p_max = @reviews.count
        
        @reviews = @reviews[@p..@p+9]
        
    end

    def new
        @review = current_user.reviews.new
        @universities = University.all.collect {|u| [(u.name || '(no name)') + '  (' + (u.city || '(no city)') + ', ' + (u.country || '(no country)') + ')', u.id] }
        @universities.sort! { |x,y| x[0] <=> y[0] }
    end
    
    def create
        @review = current_user.reviews.create(review_params)
        
        @university = University.find_by_id(params[:university_id])
        
        if(@university == nil)
            @university = University.create(university_params)
            if !@university.save
                render 'new'
            end
        end
        
        @review.course.university = @university
        
        # TODO: Tell Postgres that this is the default value somehow
        @review.status = :pending
        
        if @review.save
            #TODO: redirect to "My Reviews" or similar
            redirect_to reviews_path
        else
            render 'new'
        end
    end
    
    def edit
        @review = Review.find_by_id(params[:id])
        @universities = University.all.collect {|u| [(u.name || '(no name)') + '  (' + (u.city || '(no city)') + ', ' + (u.country || '(no country)') + ')', u.id] }
        @universities.sort! { |x,y| x[0] <=> y[0] }
    end
    
    def update
        @review = Review.find(params[:id])
        if !@review.update(review_params)
            render 'new'
        end
        
        @university = University.find_by_id(params[:university_id])
        
        if(@university == nil)
            @university = University.create(university_params)
            if !@university.save
                render 'new'
            end
        end
        
        @review.course.university = @university
        
        #TODO: Add proper date logic
        
        if @review.save
            #TODO: redirect to "My Reviews" or similar
            redirect_to reviews_path
        else
            render 'new'
        end
    end
    
    def destroy
        @review = Review.find(params[:id])
        @review.course.destroy
        @review.umd_course.destroy
        @review.destroy
        
        redirect_to reviews_path(:p => params[:p], :status => params[:status])
    end
    
    def user
        
        @reviews = current_user.reviews
        
        @p = params[:p].to_i || 0
        
        if @p < 0
            redirect_to my_reviews_path(:p => 0)
        end
        
        if @reviews.count > 10 && @p > @reviews.count - 10
            redirect_to my_reviews_path(:p => @reviews.count - 10)
        end
        
        @p_max = @reviews.count
        
        @reviews = @reviews[@p..@p+9]
    
    end
    
    private
    
    def review_params
        params.require(:review).permit(:id, :dept, :date_sent, :date_due, 
                                       :date_received, :note, :program_sponsor, 
                                       :program_name, :program_term, :status,
                                       course_attributes: [:id, :name, :code, :language])
    end
    
    def university_params
        params.require(:university).permit(:name, :city, :country)
    end

end
