class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  MINIMUM_PASSWORD_LENGTH = 6

  include NameOfPerson::AssignableName
  include Tenant

  has_secure_password
  has_secure_token :auth_token

  before_validation :normalize_email

  has_many :collaborators, dependent: :destroy
  has_many :accounts, through: :collaborators

  validates :first_name, presence: true
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX } # rubocop:disable Layout/LineLength
  validates :password, presence: true, length: { minimum: MINIMUM_PASSWORD_LENGTH }, allow_blank: true

  def valid_password?(password)
    errors.add(:password, "can't be blank") if password.blank?
    errors.add(:password, "is too short (minimum is 6 characters)") if password.to_s.length < MINIMUM_PASSWORD_LENGTH

    password.present? && password.to_s.length >= MINIMUM_PASSWORD_LENGTH
  end

  private

  def normalize_email
    self.email = email.to_s.strip.downcase
  end
end
