class AddAuthenticationToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :token, :string
  end
end
