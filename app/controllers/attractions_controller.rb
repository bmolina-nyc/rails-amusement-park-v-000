class AttractionsController < ApplicationController
  def index
      @user = current_user
      @attractions = Attraction.all
  end

  def show
    @user = current_user
    @attraction = Attraction.find_by(id: params[:id])
  end

  def update 
    @user = current_user
    @attraction = Attraction.find_by(id: params[:id])
  

    if @user.height > @attraction.min_height && @user.tickets > @attraction.tickets
      flash[:notice] = "Thanks for riding the #{@attraction.name}!"
        @user.tickets -= @attraction.tickets
        @user.nausea += @attraction.nausea_rating
        @user.save 
        redirect_to user_path(@user)
    elsif @user.height < @attraction.min_height && @user.tickets < @attraction.tickets
        flash[:notice] = "You are not tall enough to ride the #{@attraction.name} and You do not have enough tickets to ride the #{@attraction.name}" 
        redirect_to user_path(@user)
    elsif @user.height < @attraction.min_height 
        flash[:notice] = "You are not tall enough to ride the #{@attraction.name}" 
        redirect_to user_path(@user)
    elsif @user.tickets < @attraction.tickets 
        flash[:notice] = "You do not have enough tickets to ride the #{@attraction.name}"
        redirect_to user_path(@user)
    end
  end

end
