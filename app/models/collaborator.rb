class Collaborator < ApplicationRecord
  has_secure_token

  acts_as_tenant :account
  belongs_to :user

  enum role: %w[owner editor].index_with { |role| role }

  validates :user, uniqueness: { scope: :account_id, message: "is already in the account" }
end
