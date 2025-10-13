class TripsController < ApplicationController
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
    @trip = Trip.find(params[:id])
  end

  private
  def trip_params
    params.require(:trip).permit(:title, :destination, :start_date, :end_date, :description, media: [])
  end
end
