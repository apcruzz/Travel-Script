class JournalEntry < ApplicationRecord
  belongs_to :trip
  has_many_attached :media  # for multiple photos or videos
  validates :content, presence: true, length: { minimum: 10 }
end
