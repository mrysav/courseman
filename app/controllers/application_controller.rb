class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user
  helper_method :require_valid_user
  
  def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def require_valid_user
      if session[:user_id] == nil
          respond_to do |format|
              format.html { redirect_to root_path, :notice => "Must be logged in to do that." }
          end
      end
  end
end
