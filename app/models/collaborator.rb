class Collaborator < ApplicationRecord
  has_secure_token

  acts_as_tenant :account
  belongs_to :user

  counter_culture :account, column_name: proc { |record| record.owner? ? "owners_count" : nil }

  enum role: %w[owner editor].index_with { |role| role }

  validates :user, uniqueness: { scope: :account_id, message: "is already in the account" }

  scope :alphabetically, -> { order("users.first_name": :asc).references(:user) }

  delegate :name, :email, to: :user

  def invite_accepted?
    joined_at.present?
  end

  def invite_pending?
    joined_at.nil?
  end
end
