class User < ApplicationRecord
  before_validation :generate_api_key

  validates :name, presence: true
  validates :email, uniqueness: true, presence: true

  has_secure_password

  private

    def generate_api_key
      self.api_key = SecureRandom.hex
    end
end