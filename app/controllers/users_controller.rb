class UsersController < ApplicationController

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
    @user = current_user || User.first # TODO remove || User.first
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = current_user || User.first # TODO remove || User.first
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = current_user || User.first # TODO remove || User.first
    if @user.destroy
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
