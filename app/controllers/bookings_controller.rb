class BookingsController < ApplicationController
  def new
    @location = Location.find(params[:id])
    @booking = Booking.new
  end

  def create
    @booking = Booking.new
    @user = current_user
    @location = Location.find(params[:location_id])
    @booking.user = @user
    @booking.location = @location
    @booking.status = 1 # status pending
    if @booking.save
      redirect_to location_path(@location)
    else
      redirect_to new, status: :unprocessable_entity
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
