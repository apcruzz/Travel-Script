class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :journal_entries, dependent: :destroy
  has_many :trips, dependent: :destroy
  has_many :reactions, dependent: :destroy


  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :name, presence: true, length: { maximum: 100 }
  validates :email_address, presence: true

  def self.new_form_hash(user_hash)
    user = User.new user_hash
    user.password_digest = 0
    user
  end

  def has_password?
    self.password_digest.nil? || self.password_digest != "0"
  end
end
