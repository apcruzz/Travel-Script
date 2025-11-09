class JournalEntriesController < ApplicationController
  before_action :set_trip
  before_action :set_journal_entry, only: %i[show edit update destroy]
  before_action :require_login
  before_action :set_trip
  before_action :set_journal_entry, only: %i[show edit update destroy]

  def index
    @journal_entries = Current.user.journal_entries.where(trip: @trip).order(date: :desc)
  end

  def show; end

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

  def edit; end

  def update
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
    @journal_entry.destroy
    redirect_to trip_journal_entries_path(@trip), notice: "Journal entry deleted."
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
    # .expect is not working for me here, but .permit workds fine.
  end
end
