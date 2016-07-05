class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :logged_out_user, only: [:new, :create]

  def index
    @users = User.all.order(:id)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
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
    @user = current_user
    if @user.update(user_params)
      flash[:success] = "Account updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = current_user
    if @user.destroy
      flash[:success] = "Account deleted"
      redirect_to users_path
    else
      render 'show'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
