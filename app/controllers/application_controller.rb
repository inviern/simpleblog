class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
    def for_logged_out
      if logged_in?
        redirect_to root_path
        return false
      end
    end

    def for_logged_in
      unless logged_in?
        redirect_to root_path
        return false
      end
    end
end
