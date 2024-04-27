class BookingsController < ApplicationController
  def edit
    @booking = Booking.find(params[:id])
  end

  # def update
  #   @booking = Booking.find(params[:id])
  #   @booking.update(booking_params)
  #   redirect_to booking_path(@booking)
  # end

  # private

  # def booking_params
  #   params.require(:booking).permit(:status)
  # end
end
