class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  # GET /locations
  def index
    if params[:query].present?
      @locations = Location.search_by_name_address_description(params[:query])
    else
    @locations = Location.all
    @markers = @locations.geocoded.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
        info_window: render_to_string(partial: "popup", locals: { location: location})
      }
      end
    end
  end

  # GET /locations/:id
  def show
    @booking = Booking.new
    @pending_booking = Booking.find_by(user: current_user, location: params[:id])
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # POST /locations
  def create
    @location = current_user.locations.build(location_params)
    if @location.save
      redirect_to @location, notice: 'Location was successfully created.', status: :created
    else
      render :new, status: :unprocessable_entity # Added status: :unprocessable_entity
    end
  end

  # GET /locations/:id/edit
  def edit
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
    @location.destroy
    redirect_to locations_url, notice: 'Location was successfully destroyed.', status: :see_other
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end

  def location_params
    params.require(:location).permit(:name, :address, :description, :price, :image_url)
  end
end
