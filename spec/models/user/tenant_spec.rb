require "rails_helper"

RSpec.describe User::Tenant do
  describe "#collaborator_exists?" do
    let(:account) { create(:account) }
    let(:user) { create(:user) }

    it "returns true if the user is a member of the account" do
      create(:collaborator, user: user, account: account)

      expect(user.collaborator_exists?(account)).to be_truthy
    end

    it "returns false if the user is not a member of the account" do
      expect(user.collaborator_exists?(account)).to be_falsy
    end
  end

  describe "#invite_accepted?" do
    let(:account) { create(:account) }
    let(:user) { create(:user) }

    it "returns true if the user has accepted the invitation" do
      create(:collaborator, user: user, account: account, joined_at: Time.zone.now)

      expect(user.invite_accepted?(account)).to be_truthy
    end

    it "returns false if the user is not a member of the account" do
      expect(user.invite_accepted?(account)).to be_falsy
    end

    it "returns false if the user's invitation is pending" do
      create(:collaborator, :pending, user: user, account: account)

      expect(user.invite_accepted?(account)).to be_falsy
    end
  end

  describe "#invite_pending?" do
    let(:account) { create(:account) }
    let(:user) { create(:user) }

    it "returns false if the user has accepted the invitation" do
      create(:collaborator, user: user, account: account, joined_at: Time.zone.now)

      expect(user.invite_pending?(account)).to be_falsy
    end

    it "returns false if the user is not a member of the account" do
      expect(user.invite_pending?(account)).to be_falsy
    end

    it "returns true if the user's invitation is pending" do
      create(:collaborator, :pending, user: user, account: account)

      expect(user.invite_pending?(account)).to be_truthy
    end
  end

  describe "#account_owner?" do
    let(:account) { create(:account) }
    let(:user) { create(:user) }

    it "returns true if the user is the owner of the account" do
      create(:collaborator, :owner, user: user, account: account)

      expect(user.account_owner?(account)).to be_truthy
    end

    it "returns false it the user is not the owner of the account" do
      create(:collaborator, user: user, account: account)

      expect(user.account_owner?(account)).to be_falsy
    end

    it "returns false if the user is not a member of the account" do
      expect(user.account_owner?(account)).to be_falsy
    end
  end

  describe "#find_collaborator" do
    let(:account) { create(:account) }
    let(:user) { create(:user) }

    it "finds the collaborator" do
      collaborator = create(:collaborator, user: user, account: account)

      expect(user.find_collaborator(account)).to eq(collaborator)
    end

    it "returns nil if no collaborator is found" do
      expect(user.find_collaborator(account)).to eq(nil)
    end
  end
end
