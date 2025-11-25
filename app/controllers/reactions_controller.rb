class ReactionsController < ApplicationController
  before_action :set_reaction, only: [ :show, :edit, :update, :destroy ]

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
    @reaction = Reaction.new(reaction_params)
    if @reaction.save
      redirect_to @reaction, notice: "Reaction created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /reactions/:id/edit
  def edit
  end

  # PATCH/PUT /reactions/:id
  def update
    if @reaction.update(reaction_params)
      redirect_to @reaction, notice: "Reaction updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /reactions/:id
  def destroy
    @reaction.destroy
    redirect_to reactions_path, notice: "Reaction removed."
  end

  private

  def set_reaction
    @reaction = Reaction.find(params[:id])
  end

  def reaction_params
    params.require(:reaction).permit(:user_id, :journal_entry_id, :reaction_type)
  end
end
