class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  MINIMUM_PASSWORD_LENGTH = 6

  include NameOfPerson::AssignableName

  has_secure_password
  has_secure_token :auth_token

  before_validation :normalize_email

  validates :first_name, presence: true
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX } # rubocop:disable Layout/LineLength
  validates :password, presence: true, length: { minimum: MINIMUM_PASSWORD_LENGTH }, on: :create

  private

  def normalize_email
    self.email = email.to_s.strip.downcase
  end
end
