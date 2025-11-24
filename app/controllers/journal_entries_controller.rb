class JournalEntriesController < ApplicationController
  before_action :require_login, except: [ :index, :show ]
  before_action :set_trip
  before_action :set_journal_entry, only: %i[show edit update destroy]
  before_action :authorize_user!, only: [ :edit, :update, :destroy ]


  # def index before ig inspiration
  #   # Everyone can view a trip's journal entries
  #   @journal_entries = @trip.journal_entries.order(date: :desc)
  # end
  #

  def index
    @journal_entries = @trip.journal_entries.order(date: :desc)
    @trips = Current.user.trips
  end

  # def index
  #   redirect_to trips_path
  # end

  def show
    # Anyone can view
  end

  def new
    @journal_entry = @trip.journal_entries.new
  end

  def create
    @journal_entry = @trip.journal_entries.new(journal_entry_params)
    @journal_entry.user = Current.user

    if @journal_entry.save
      redirect_to trip_journal_entries_path(@trip), notice: "Journal entry created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    redirect_to trip_journal_entry_path(@trip, @journal_entry),
      alert: "You cannot edit this journal entry." unless @journal_entry.user == Current.user
  end

  def update
    return redirect_to trip_journal_entry_path(@trip, @journal_entry),
      alert: "You cannot edit this journal entry." unless @journal_entry.user == Current.user

    if params[:remove_media_ids].present?
      params[:remove_media_ids].each do |id|
        @journal_entry.media.find(id).purge
      end
    end

    if @journal_entry.update(journal_entry_params)
      redirect_to trip_journal_entry_path(@trip, @journal_entry), notice: "Journal entry updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    return redirect_to trip_journal_entry_path(@trip, @journal_entry),
      alert: "You cannot delete this journal entry." unless @journal_entry.user == Current.user

    @journal_entry.destroy
    redirect_to trip_journal_entries_path(@trip), notice: "Journal entry deleted."
  end

  def authorize_user!
    unless @journal_entry.user == Current.user
      redirect_to trip_journal_entries_path(@trip), alert: "You are not authorized to modify this entry."
    end
  end


  private

  def set_trip
    @trip = Trip.find(params[:trip_id])
  end

  def set_journal_entry
    @journal_entry = @trip.journal_entries.find(params[:id])
  end

  def journal_entry_params
    params.require(:journal_entry).permit(:title, :content, :date, :image_url, media: [])
  end
end
