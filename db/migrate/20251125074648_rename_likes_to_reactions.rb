class RenameLikesToReactions < ActiveRecord::Migration[8.0]
  def change
    rename_table :likes, :reactions
  end
end
