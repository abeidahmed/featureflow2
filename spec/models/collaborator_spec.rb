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

  describe ".search" do
    it "filters the members by name" do
      user = create(:user, name: "Jay Machis")
      collaborator = create(:collaborator, user: user)

      expect(described_class.includes(:user).search("Jay mach").ids).to match_array([collaborator.id])
    end

    it "filters the members by email" do
      user = create(:user, email: "logoo@gmail.com")
      collaborator = create(:collaborator, user: user)

      expect(described_class.includes(:user).search("logoo").ids).to match_array([collaborator.id])
    end
  end

  describe "#unrevokable?" do
    let(:account) { create(:account) }
    let(:user) { create(:user) }

    before do
      Current.user = user
    end

    after do
      Current.user = nil
    end

    context "when being the owner" do
      it "returns true if sole owner" do
        collaborator = create(:collaborator, :owner, user: user, account: account)

        collaborator.reload
        expect(collaborator.unrevokable?).to eq(true)
      end

      it "returns false if multiple owners" do
        create(:collaborator, :owner, account: account)
        collaborator = create(:collaborator, :owner, user: user, account: account)

        collaborator.reload
        expect(collaborator.unrevokable?).to eq(false)
      end
    end

    context "when being an editor" do
      it "returns false" do
        create(:collaborator, :owner, account: account)
        collaborator = create(:collaborator, user: user, account: account)

        collaborator.reload
        expect(collaborator.unrevokable?).to eq(false)
      end
    end
  end
end
