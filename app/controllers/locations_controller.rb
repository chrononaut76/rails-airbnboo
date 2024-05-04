class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  # GET /locations
  def index
    if current_user.is_host
      @locations = Location.find_by(user: current_user)
    else
      @locations = Location.all
    end
    @markers = @locations.geocoded.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
        info_window: render_to_string(partial: "popup", locals: { location: location})
      }
    end
  end

  # GET /locations/:id
  def show
    if current_user.is_host
      @booking = Booking.find_by(location: params[:id])
    else
      @booking = Booking.new
      @pending_booking = Booking.find_by(user: current_user, location: params[:id])
    end
  end

  # GET /locations/new
  def new
    if current_user.is_host
      @location = Location.new
    else
      redirect_to root, status: :unauthorized
    end
  end

  # POST /locations
  def create
    @location = Location.new(location_params)
    if @location.save
      redirect_to @location, notice: 'Location was successfully created.', status: :created
    else
      render :new, status: :unprocessable_entity # Added status: :unprocessable_entity
    end
  end

  # GET /locations/:id/edit
  def edit
    unless current_user.is_host
      redirect_to root, status: :unauthorized
    end
  end

  # PATCH/PUT /locations/:id
  def update
    if @location.update(location_params)
      redirect_to @location, notice: 'Location was successfully updated.', status: :ok
    else
      render :edit, status: :unprocessable_entity # Added status: :unprocessable_entity
    end
  end

  # DELETE /locations/:id
  def destroy
    if current_user.is_host
      @location.destroy
      redirect_to locations_url, notice: 'Location was successfully destroyed.', status: :see_other
    else
      redirect_to root, status: :unauthorized
    end
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end

  def location_params
    params.require(:location).permit(:name, :address, :description, :price, :image_url)
  end
end
