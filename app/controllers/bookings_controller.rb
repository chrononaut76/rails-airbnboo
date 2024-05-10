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
    @location = Location.find(params[:location_id])
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.location = @location
    @booking.status = 1 # status pending
    if @booking.save!
      redirect_to location_path(@location), notice: 'Booking was created successfully!'
    else
      render :new, location_path(@location), status: :unprocessable_entity  # Use new_location_booking_path
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
