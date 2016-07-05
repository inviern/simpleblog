class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
    def logged_in_user
      redirect_to login_path unless logged_in?
    end

    def logged_out_user
      redirect_to root_path if logged_in?
    end
end
