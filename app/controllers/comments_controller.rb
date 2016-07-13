class CommentsController < ApplicationController
  before_action :require_login, only: [:create, :destroy]
  before_action :author_user, only: [:destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    @comment.author = current_user
    if @comment.save
      flash[:success] = 'Comment added'
      redirect_to blog_post_path(@comment.post.author.name, @comment.post)
    else
      @post = @comment.post
      render 'posts/show'
    end
  end

  def destroy
    if @comment.destroy
      flash[:success] = 'Comment deleted'
      redirect_to blog_post_path(@comment.post.author.name, @comment.post)
    else
      @post = @comment.post
      render 'posts/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def author_user
    @comment = Comment.find(params[:id])
    redirect_to root_path unless current_user == @comment.author
  end
end
