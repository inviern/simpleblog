class HomeController < ApplicationController
  ITEMS_PER_PAGE = 3

  def index
    @posts = Post.order(created_at: :desc)
                 .paginate(page: params[:page], per_page: ITEMS_PER_PAGE)
  end
end
