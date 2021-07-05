require "rails_helper"

RSpec.describe Collaborator, type: :model do
  subject(:collaborator) { build(:collaborator) }

  describe "associations" do
    it { is_expected.to belong_to(:account) }

    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    it { is_expected.to validate_uniqueness_of(:user).scoped_to(:account_id).with_message("is already in the account") }

    it { is_expected.to define_enum_for(:role).with_values(owner: "owner", editor: "editor").backed_by_column_of_type(:string) }
  end

  describe "callbacks" do
    it "registers a new token" do
      collaborator = create(:collaborator, token: nil)

      expect(collaborator.token).to be_present
    end
  end

  describe "counter_cache" do
    let(:account) { create(:account) }

    it "increments the owners count when owner is created" do
      create(:collaborator, :owner, account: account)

      account.reload
      expect(account.owners_count).to eq(1)
    end

    it "does not increment the owners count when member is created" do
      create(:collaborator, account: account)

      account.reload
      expect(account.owners_count).to eq(0)
    end
  end

  describe ".alphabetically" do
    it "orders the collaborators alphabetically" do
      user1 = create(:user, name: "Rik")
      user2 = create(:user, name: "Abeid")
      collaborator1 = create(:collaborator, user: user1)
      collaborator2 = create(:collaborator, user: user2)

      expect(described_class.alphabetically.includes(:user).ids).to eq([collaborator2.id, collaborator1.id])
    end
  end
end
