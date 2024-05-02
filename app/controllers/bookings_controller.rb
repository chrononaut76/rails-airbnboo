class BookingsController < ApplicationController
  def create
    @booking = Booking.new(booking_params)
    @booking.location = @location
    if @booking.save
      redirect_to location_path(@location)
    else
      redirect_to location_path(@location), status: :unprocessable_entity
    end
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
    params.require(:booking).permit(:location_id)
  end
end
