class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :journal_entries, dependent: :destroy
  has_many :trips, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :name, presence: true, length: { maximum: 100 }
end
