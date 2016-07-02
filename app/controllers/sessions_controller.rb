class SessionsController < ApplicationController

  before_filter :for_logged_out, only: [:new, :create]
  before_filter :for_logged_in, only: [:destroy]

  def new
  end

  def create
    if login(params[:session][:email], params[:session][:password])
      flash[:success] = "Logged in as <b>#{current_user.name}</b>"
      redirect_to blog_path(current_user.name)
    else
      flash.now[:danger] = "Log in failed"
      render 'new'
    end
  end

  def destroy
    logout
    flash[:success] = "Logged out"
    redirect_to root_path
  end
end
