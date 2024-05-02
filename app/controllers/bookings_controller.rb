class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @location = Location.find(params[:location_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @location = Location.find(params[:location_id])
    @booking.location = @location
    @booking.save
    redirect_to location_path(@location)
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  # def update
  #   @booking = Booking.find(params[:id])
  #   @booking.update(booking_params)
  #   redirect_to booking_path(@booking)
  # end

  private

  def booking_params
    params.require(:booking).permit(:status)
  end
end
