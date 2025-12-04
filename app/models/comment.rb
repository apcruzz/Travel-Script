class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :journal_entry

  validates :content, presence: true, length: { maximum: 1_000 }
end
