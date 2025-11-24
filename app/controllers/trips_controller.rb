class TripsController < ApplicationController
  before_action :require_login, except: [ :index, :show ]
  before_action :load_trip, except: [ :index, :new, :create ]

  # original index before the IG inspiration
  # def index
  #   @user = Current.user
  #   @trips = Trip.all.order(created_at: :desc)
  # end

  def index
    # @trips = Current.user.trips   # user’s trips → right side
    # @feed_entries = JournalEntry.order("RANDOM()").limit(20)  # main feed
    @trips = Trip.all
    @feed_entries = JournalEntry.order(date: :desc)
  end



  def show
  end

  def new
    @trip = Current.user.trips.new
  end

  def create
    @trip = Current.user.trips.new(trip_params)
    if @trip.save
      redirect_to trips_path, notice: "Trip was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    redirect_to @trip, alert: "You cannot edit this trip." unless @trip.user == Current.user
  end

  def update
    return redirect_to @trip, alert: "You cannot edit this trip." unless @trip.user == Current.user

    if params[:remove_media_ids]
      params[:remove_media_ids].each do |id|
        media = @trip.media.find_by_id(id)
        media.purge if media
      end
    end

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
    return redirect_to @trip, alert: "You cannot delete this trip." unless @trip.user == Current.user

    @trip.destroy
    redirect_to trips_path, alert: "Trip was successfully deleted."
  end

  private

  def trip_params
    params.expect(trip: [ :title, :destination, :start_date, :end_date, :description, media: [] ])
  end

  def load_trip
    @trip = Trip.find(params[:id])
  end
end
