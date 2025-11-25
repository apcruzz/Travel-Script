class AddReactionTypeToReactions < ActiveRecord::Migration[8.0]
  def change
    add_column :reactions, :reaction_type, :string
  end
end
