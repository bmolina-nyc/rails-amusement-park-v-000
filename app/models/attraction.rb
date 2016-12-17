class Attraction < ActiveRecord::Base
  # write associations here
  has_many :rides
  has_many :users, through: :rides

  def admin_update_ride?
    params[:user_id].nil? && current_user.admin?
  end


  def can_take_ride?
    @user = current_user
    if @user.height > @attraction.min_height && @user.tickets > @attraction.tickets
      flash[:notice] = "Thanks for riding the #{@attraction.name}!"
      @user.tickets -= @attraction.tickets
      @user.nausea += @attraction.nausea_rating
      @user.save 
      redirect_to user_path(@user)
    end
  end

  def not_enough_tickets_height?
    if @user.height < @attraction.min_height && @user.tickets < @attraction.tickets
      flash[:notice] = "You are not tall enough to ride the #{@attraction.name} and You do not have enough tickets to ride the #{@attraction.name}" 
      redirect_to user_path(@user)
    end
  end

  def too_short?
    if @user.height < @attraction.min_height 
      flash[:notice] = "You are not tall enough to ride the #{@attraction.name}" 
      redirect_to user_path(@user)
    end
  end

  def lack_tickets?
    if @user.tickets < @attraction.tickets 
        flash[:notice] = "You do not have enough tickets to ride the #{@attraction.name}"
        redirect_to user_path(@user)
    end
  end

  def current_user
    @user = User.find_by(id: session[:user_id])
  end

end
