class Collaborator < ApplicationRecord
  DEFAULT_LIMIT = 16

  has_secure_token

  acts_as_tenant :account
  belongs_to :user

  counter_culture :account, column_name: proc { |record| record.owner? ? "owners_count" : nil }

  enum role: %w[owner editor].index_with { |role| role }

  validates :user, uniqueness: { scope: :account_id, message: "is already in the account" }

  scope :alphabetically, -> { order("users.first_name": :asc).references(:user) }

  delegate :name, :email, to: :user

  def self.search(query)
    if query.present?
      where(
        "users.email iLIKE :query OR CONCAT_WS(
          ' ', users.first_name, users.last_name
        ) iLIKE :query", query: "%#{query}%"
      ).references(:users)
    else
      all
    end
  end

  def invite_accepted?
    joined_at.present?
  end

  def invite_pending?
    joined_at.nil?
  end

  def unrevokable?
    account.owners_count == 1 && owner? && Current.user == user
  end
end
