class UsersController < ApplicationController
  before_action :must_log_in, only: [:show]
  before_action :current_user, only: [:new, :show, :update]

  def new
    # @user = User.new 
  end

  def create  
    @user = User.new(user_params)
    if @user.save 
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      redirect_to new_user_path
    end
  end

  def show 
    # @user = User.find_by(id: params[:id])
  end




  def user_params
    params.require(:user).permit(:id, :name, :password, :happiness, :nausea, :tickets, :height)
  end
end
