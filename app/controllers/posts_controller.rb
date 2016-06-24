class PostsController < ApplicationController
  def index
    @author = User.find_by(name: params[:author])
    @posts = Post.where(author: @author)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @post.author = current_user || User.first # TODO remove || User.first
  end

  def edit
    current_user ||= User.first # TODO remove
    @post = Post.where(author: current_user).find(params[:id])
  end

  def create
    current_user ||= User.first # TODO remove
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save
      redirect_to blog_path(current_user.name)
    else
      render 'new'
    end
  end

  def update
    current_user ||= User.first # TODO remove
    @post = Post.where(author: current_user).find(params[:id])
    if @post.update(post_params)
      redirect_to blog_path(current_user.name)
    else
      render 'edit'
    end
  end

  def destroy
    current_user ||= User.first # TODO remove
    @post = Post.where(author: current_user).find(params[:id])
    if @post.destroy
      redirect_to blog_path(current_user.name)
    else
      render 'show'
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :text)
  end

end
