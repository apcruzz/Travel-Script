class CreateJournalEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :journal_entries do |t|
      t.string :title
      t.text :content
      t.datetime :date
      t.string :image_url
      t.references :trip, null: false, foreign_key: true

      t.timestamps
    end
  end
end
