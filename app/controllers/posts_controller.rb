class PostsController < ApplicationController
  ITEMS_PER_PAGE = 10

  before_action :logged_in_user, only: [:new, :edit, :create, :update, :destroy]
  before_action :author_user, only: [:edit, :update, :destroy]

  def index
    @author = User.find_by(name: params[:author])
    @posts = Post.where(author: @author).order(created_at: :desc)
                 .paginate(page: params[:page], per_page: ITEMS_PER_PAGE)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @post.author = current_user
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save
      flash[:success] = 'Post created'
      redirect_to blog_path(current_user.name)
    else
      render 'new'
    end
  end

  def update
    if @post.update(post_params)
      flash[:success] = 'Post updated'
      redirect_to blog_path(current_user.name)
    else
      render 'edit'
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = 'Post deleted'
      redirect_to blog_path(current_user.name)
    else
      render 'show'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def author_user
    @post = Post.find(params[:id])
    redirect_to root_path unless current_user == @post.author
  end
end
