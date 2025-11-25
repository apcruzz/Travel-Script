class ReactionsController < ApplicationController
  before_action :set_journal_entry

  def create
    @journal_entry.reactions.create(user: Current.user)
    redirect_back fallback_location: trips_path
  end

  def destroy
    @journal_entry.reactions.where(user: Current.user).destroy_all
    redirect_back fallback_location: trips_path
  end

  private

  def set_journal_entry
    @journal_entry = JournalEntry.find(params[:journal_entry_id])
  end
end
