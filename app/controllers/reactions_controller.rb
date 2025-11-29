class ReactionsController < ApplicationController
  before_action :require_login, except: [ :index, :show ]
  before_action :set_reaction, only: [ :show, :edit ]
  before_action :set_context_from_nested_routes, only: [ :create, :update, :destroy ]
  before_action :set_nested_reaction, only: [ :update, :destroy ]

  # def create
  #   @journal_entry.reactions.create(user: Current.user)
  #   redirect_back fallback_location: trips_path
  # end

  # def destroy
  #   @journal_entry.reactions.where(user: Current.user).destroy_all
  #   redirect_back fallback_location: trips_path
  # end

  # private

  # def set_journal_entry
  #   @journal_entry = JournalEntry.find(params[:journal_entry_id])
  # end
  #
  # UPDATED REACTIONS, ADDED MORE

  # GET /reactions
  def index
    @reactions = Reaction.all
  end

  # GET /reactions/:id
  def show
  end

  # GET /reactions/new
  def new
    @reaction = Reaction.new
  end

  # POST /reactions
  def create
    @reaction = @journal_entry.reactions.find_or_initialize_by(user: Current.user)
    @reaction.reaction_type = params[:reaction_type]

    if @reaction.save
      redirect_back fallback_location: trips_path
    else
      redirect_back fallback_location: trips_path,
        alert: @reaction.errors.full_messages.to_sentence.presence || "Unable to react."
    end
  end

  # GET /reactions/:id/edit
  def edit
  end

  # PATCH/PUT /reactions/:id
  def update
    if @reaction&.update(reaction_type: params[:reaction_type])
      redirect_back fallback_location: trips_path
    else
      redirect_back fallback_location: trips_path,
        alert: @reaction&.errors&.full_messages&.to_sentence || "Unable to update reaction."
    end
  end

  # DELETE /reactions/:id
  def destroy
    if @reaction&.destroy
      redirect_back fallback_location: trips_path
    else
      redirect_back fallback_location: trips_path, alert: "Reaction could not be removed."
    end
  end

  private

  def set_reaction
    @reaction = Reaction.find(params[:id])
  end

  def set_context_from_nested_routes
    @trip = Trip.find(params[:trip_id])
    @journal_entry = @trip.journal_entries.find(params[:journal_entry_id])
  end

  def set_nested_reaction
    @reaction = @journal_entry.reactions.find_by(user: Current.user)
  end

  # def reaction_params
  #   params.require(:reaction).permit(:user_id, :journal_entry_id, :reaction_type)
  # end

  def reaction_params
    params.expect(reaction: [ :user_id, :journal_entry_id, :reaction_type ])
  end
end
