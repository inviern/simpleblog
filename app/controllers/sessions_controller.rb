class SessionsController < ApplicationController

  before_filter :for_logged_out, only: [:new, :create]
  before_filter :for_logged_in, only: [:destroy]

  def new
  end

  def create
    if login(params[:session][:email], params[:session][:password])
      redirect_to blog_path(current_user.name)
    else
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end
