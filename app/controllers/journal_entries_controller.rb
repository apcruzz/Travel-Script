class JournalEntriesController < ApplicationController
  before_action :set_trip
  before_action :set_journal_entry, only: [ :show, :edit, :update, :destroy ]

  def index
    @journal_entries = @trip.journal_entries
  end

  def show
  end

  def new
    @trip = Trip.find(params[:trip_id])
    @journal_entry = JournalEntry.new
    @journal_entries = @trip.journal_entries
  end

  def create
    @journal_entry = @trip.journal_entries.new(journal_entry_params)
    if @journal_entry.save
      redirect_to trip_journal_entries_path(@trip), notice: "Journal entry created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    # Remove selected media if checkboxes were checked
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
    params.require(:journal_entry).permit(:title, :content, :date, :image_url)
  end
end
