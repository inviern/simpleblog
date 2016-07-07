class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :author_user, only: [:destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    @comment.author = current_user
    if @comment.save
      flash[:success] = 'Comment added'
      redirect_to blog_post_path(@comment.post.author.name, @comment.post)
    else
      flash[:danger] = 'Error adding comment'
      redirect_to blog_post_path(@comment.post.author.name, @comment.post)
    end
  end

  def destroy
    if @comment.destroy
      flash[:success] = 'Comment deleted'
      redirect_to blog_post_path(@comment.post.author.name, @comment.post)
    else
      flash[:danger] = 'Error deleting comment'
      redirect_to blog_post_path(@comment.post.author.name, @comment.post)
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
