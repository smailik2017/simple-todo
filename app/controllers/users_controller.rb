class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    redirect_to root_path if current_user.default?
    @users = User.all.sort
  end

  def edit
    redirect_to root_path if current_user.default?
    redirect_to users_path if current_user.id == params[:id].to_i
    @user = User.find(params[:id])
  end

  def update
    redirect_to root_path if current_user.default?
    redirect_to users_path if current_user.id == params[:id].to_i
    @user = User.find(params[:id])
    @user.update(params.require(:user).permit(:role_id))
    redirect_to users_path
  end

end
