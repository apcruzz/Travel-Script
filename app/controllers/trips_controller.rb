class TripsController < ApplicationController
  before_action :load_trip, except: [ :index, :new, :create ]

  def index
    @trips = Trip.all
  end
  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      redirect_to trips_path, notice: "Trip was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    # Remove selected images
    if params[:remove_media_ids]
      params[:remove_media_ids].each do |id|
        media = @trip.media.find_by_id(id)
        media.purge if media
      end
    end

    # Attach new images if present
    if params[:trip][:media].present?
      @trip.media.attach(params[:trip][:media])
    end

    if @trip.update(trip_params.except(:media))
      redirect_to @trip, notice: "Trip was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @trip.destroy
    redirect_to trips_path, alert: "Trip was successfully deleted."
  end

  private
  def trip_params
    params.require(:trip).permit(:title, :destination, :start_date, :end_date, :description, media: [])
  end

  def load_trip
    @trip = Trip.find(params[:id])
  end
end
