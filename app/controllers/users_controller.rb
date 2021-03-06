class UsersController < ApplicationController
  ITEMS_PER_PAGE = 15

  before_action :require_login, only: [:index, :edit, :update, :destroy]
  before_action :logged_out_user, only: [:new, :create]
  before_action :set_user_to_current, only: [:edit, :update, :destroy]

  def index
    @users = User.order(:id).paginate(page: params[:page],
                                      per_page: ITEMS_PER_PAGE)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user.email, params[:user][:password])
      flash[:success] = "Account <b>#{@user.name}</b> created"
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'Account updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = 'Account deleted'
      redirect_to users_path
    else
      render 'show'
    end
  end

  private

  def user_params
    params.require(:user)
      .permit(:name, :email, :password, :password_confirmation, :picture)
  end

  def set_user_to_current
    @user = current_user
  end
end
