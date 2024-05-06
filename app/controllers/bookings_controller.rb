class BookingsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]  # Add this line to enforce authentication

  def index
    @bookings = Booking.where(user: current_user)
  end

  def new
    @location = Location.find(params[:id])
    @booking = Booking.new
  end

  def create
    if user_signed_in? # Check if the user is signed in
      @booking = Booking.new
      @user = current_user
      @location = Location.find(params[:location_id])
      @booking.user = @user
      @booking.location = @location
      @booking.status = 1 # status pending
      if @booking.save
        redirect_to location_path(@location)
      else
        redirect_to new_location_booking_path(@location)  # Use new_location_booking_path
      end
    else
      redirect_to new_user_session_path # Redirect to the login screen
    end
  end

  # Commented out to work on a single action at a time
  # def edit
  #   @booking = Booking.find(params[:id])
  # end

  # def update
  #   @booking = Booking.find(params[:id])
  #   @booking.update(booking_params)
  #   redirect_to booking_path(@booking)
  # end

  private

  def booking_params
    params.require(:booking).permit(:location_id)
  end
end
