class ReviewsController < ApplicationController
    before_action :require_valid_user
    before_action :require_admin_user, :except => [:new, :create, :user]
    
    #TODO: Lots of the code in [#new, #edit] and [#create, #update] and [#index, #user] can be merged somehow
    
    def index 
        
        case params[:status]
        when 'approved'
            status = :approved
        when 'pending'
            status = :pending
        when 'sent'
            status = [:sent, :resent]
        else
            status = :pending
        end 

        if(params[:s] == nil || params[:s] == "")
            @reviews = Review.where(:status => status).paginate(:page => params[:page])
        else
            @reviews = Review.where(:status => status).full_search(params[:s]).paginate(:page => params[:page])
        end
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
        
        @review.umd_course = UmdCourse.create(:review_id => @review.id)
        
        if @review.save
            if(current_user.admin)
                redirect_to reviews_path
            else
                redirect_to my_reviews_path
            end
        else
            render 'new'
        end
    end

    def show
        @review = Review.find_by_id(params[:id])

        if params[:print] = "true"
            @print_view = true
        end
    end    

    def edit
        @review = Review.find_by_id(params[:id])
        @universities = University.all.collect {|u| [(u.name || '(no name)') + '  (' + (u.city || '(no city)') + ', ' + (u.country || '(no country)') + ')', u.id] }
        @universities.sort! { |x,y| x[0] <=> y[0] }
        @lib_ed_cats = lib_ed_cats
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
        
        redirect_to reviews_path()
    end
    
    def user
        @reviews = current_user.reviews.paginate(:page => params[:page]) 
    end
    
    private
    
    def review_params
        params.require(:review).permit(:id, :dept, :date_sent, :date_due, 
                                       :date_received, :note, :program_sponsor, 
                                       :program_name, :program_term, :status,
                                       course_attributes: [:id, :name, :code, :language, :syllabus],
                                       umd_course_attributes: [:id, :designator, :code, :name, :approved_by, :approved, :notes, :lib_eds => [] ])
    end
    
    def university_params
        params.require(:university).permit(:name, :city, :country)
    end
    
    def lib_ed_cats
        ['Category 3','Category 4','Category 5','Category 6','Category 7','Category 8','Category 9',
                    'Social Science without Lab', 'Social Sciences', 'Humanities', 'Logic and Quantitative Reasoning', 
                    'Natural Science without Lab', 'Natural Sciences with Lab', 'Global Perspectives', 'International Perspective',
                    'Sustainability', 'Cultural Diversity in the US', 'Fine Arts', 'Natural Sciences', 'Natural Sciences without Lab',
                    'Oral Communication and Languages', 'Writing and Information Literacy'].sort!
    end

end
