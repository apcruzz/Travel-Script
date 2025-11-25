class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :journal_entry
  REACTION_TYPES = [ "❤️", "😂", "😢", "😡", "👍" ]

  validates :reaction_type, presence: true
  validates :user_id, uniqueness: { scope: :journal_entry_id }  # prevents double-reacting
end
