class RemoveDefaultFromJournalEntries < ActiveRecord::Migration[8.0]
  def change
    change_column_default :journal_entries, :user_id, from: 1, to: nil
  end
end
