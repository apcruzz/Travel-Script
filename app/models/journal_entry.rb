class JournalEntry < ApplicationRecord
  belongs_to :trip
  belongs_to :user
  has_many_attached :media  # for multiple photos or videos
  has_many :reactions, dependent: :destroy
  validates :content, presence: true, length: { minimum: 10 }
  validates :title, presence: true, length: { minimum: 3 }
end
