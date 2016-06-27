class SessionsController < ApplicationController
  def new
  end

  def create
    if login(params[:email], params[:password])
      redirect_back_or_to(blog_path)
    else
      render 'new'
    end
  end

  def delete
    logout
    redirect_to root_path
  end
end
