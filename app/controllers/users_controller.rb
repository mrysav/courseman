class UsersController < ApplicationController
    before_filter :require_valid_user
    
    def edit
        @user = User.find(current_user.id)
    end
    
    def update
        if current_user.update(user_params)
            flash[:success] = "Profile updated successfully."
            redirect_to profile_path
        else
            render 'err'
        end
    end
    
    
    private
    
    def user_params
        params.require(:user).permit(:umnid, :major, :minor, :collegiate_unit)
    end
end
