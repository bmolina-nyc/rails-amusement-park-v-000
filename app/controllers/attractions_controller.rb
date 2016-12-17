class AttractionsController < ApplicationController
  before_action :set_attraction, only: [:show, :edit, :update]
  def index
      @user = current_user
      @attractions = Attraction.all
  end

  def new 
    @attraction = Attraction.new
  end

  def create
    @attraction = Attraction.new(attraction_params)

    if @attraction.save 
      flash[:notice] = "#{@attraction.name} created!"
      redirect_to attraction_path(@attraction)
    else
      flash[:notice] = "Sorry - couldn't create"
      redirect_to new_attraction_path
    end
  end

  def show
    @user = current_user
  end

  def edit
  end

  def update 
    @user = current_user

    if params[:user_id].nil? && current_user.admin?
      @attraction.update(attraction_params)
       flash[:notice] = "#{@attraction.name} has been updated!"
      redirect_to attraction_path(@attraction)
    elsif @user.height > @attraction.min_height && @user.tickets > @attraction.tickets
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

  private 

  def attraction_params
    params.require(:attraction).permit(:name, :tickets, :nausea_rating, :happiness_rating, :min_height)
  end

  def set_attraction
    @attraction = Attraction.find_by(id: params[:id])
  end

end
