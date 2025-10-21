class Trip < ApplicationRecord
  # belongs_to :user # Uncomment if trips are associated with users
  has_many_attached :media  # for multiple photos or videos
  has_many :journal_entries, dependent: :destroy

  validates :title, :destination, :start_date, :end_date, presence: true
  validates :description, length: { minimum: 10 }
end
