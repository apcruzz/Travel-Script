class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :journal_entry
  validates :user_id, uniqueness: { scope: :journal_entry_id }  # prevents double-reacting
end
