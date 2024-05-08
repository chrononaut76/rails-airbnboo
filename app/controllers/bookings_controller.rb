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
      @booking = Booking.new(booking_params)
      @booking.user = current_user
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

  # def edit
  #   @booking = Booking.find(params[:id])
  # end

  def update
    @booking = Booking.find(params[:id])
    @booking.update(booking_params)
    redirect_to location_path(@booking.location)
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
