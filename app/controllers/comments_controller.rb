class CommentsController < ApplicationController
  before_action :require_login
  before_action :set_trip
  before_action :set_journal_entry
  before_action :set_comment, only: :destroy
  before_action :authorize_comment_owner!, only: :destroy

  def create
    @comment = @journal_entry.comments.new(comment_params)
    @comment.user = Current.user

    if @comment.save
      redirect_to trip_journal_entry_path(@trip, @journal_entry), notice: "Comment posted."
    else
      redirect_to trip_journal_entry_path(@trip, @journal_entry), alert: @comment.errors.full_messages.to_sentence
    end
  end

  def destroy
    @comment.destroy
    redirect_to trip_journal_entry_path(@trip, @journal_entry), notice: "Comment removed."
  end

  private

  def set_trip
    @trip = Trip.find(params[:trip_id])
  end

  def set_journal_entry
    @journal_entry = @trip.journal_entries.find(params[:journal_entry_id])
  end

  def set_comment
    @comment = @journal_entry.comments.find(params[:id])
  end

  def authorize_comment_owner!
    return if @comment.user == Current.user

    redirect_to trip_journal_entry_path(@trip, @journal_entry), alert: "You cannot modify this comment."
  end

  def comment_params
    params.expect(comment: [ :content ])
  end
end
