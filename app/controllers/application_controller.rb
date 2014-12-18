class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user
  helper_method :require_valid_user
  helper_method :require_admin_user
  
  def current_user
      begin
          @current_user ||= User.find(session[:user_id]) if session[:user_id]
      rescue
          @current_user = nil
      end
  end
  
  def require_valid_user
      if session[:user_id] == nil
          respond_to do |format|
              format.html { redirect_to root_path, :notice => "Must be logged in to do that." }
          end
      end
  end

  def require_admin_user
      if (!current_user.admin)
          respond_to do |format|
              format.html { redirect_to root_path, :notice => "Invalid request." }
          end
      end
  end

end
