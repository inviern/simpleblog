class PostsController < ApplicationController

  before_filter :for_logged_in, only: [:new, :edit, :create, :update]

  def index
    @author = User.find_by(name: params[:author])
    @posts = Post.where(author: @author).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @post.author = current_user
  end

  def edit
    @post = Post.find(params[:id])
    unless current_user == @post.author
      redirect_to root_path
    end
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save
      flash[:success] = "Post created"
      redirect_to blog_path(current_user.name)
    else
      render 'new'
    end
  end

  def update
    @post = Post.find(params[:id])
    if current_user == @post.author
      if @post.update(post_params)
        flash[:success] = "Post updated"
        redirect_to blog_path(current_user.name)
      else
        render 'edit'
      end
    else
      redirect_to root_path
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if current_user == @post.author
      if @post.destroy
        flash[:success] = "Post deleted"
        redirect_to blog_path(current_user.name)
      else
        render 'show'
      end
    else
      redirect_to root_path
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :text)
  end

end
