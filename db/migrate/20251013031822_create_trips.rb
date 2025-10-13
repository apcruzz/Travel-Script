class CreateTrips < ActiveRecord::Migration[8.0]
  def change
    create_table :trips do |t|
      # t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :destination
      t.datetime :start_date
      t.datetime :end_date
      t.text :description

      t.timestamps
    end
  end
end
