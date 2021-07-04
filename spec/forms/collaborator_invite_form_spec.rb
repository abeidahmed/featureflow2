require "rails_helper"

RSpec.describe CollaboratorInviteForm do
  let(:account) { create(:account) }

  before do
    Current.account = account
    ActsAsTenant.current_tenant = account
  end

  after do
    Current.account = nil
    ActsAsTenant.current_tenant = nil
  end

  context "when the user is not registered" do
    it "invites the collaborator by creating a new user record" do
      invitable_user = described_class.new(name: "Hawa Mama", email: "  hawa@example.com ", role: "owner")

      expect do
        invitable_user.invite
      end.to change { account.collaborators.count }.by(1) && change(User, :count).by(1)

      collaborator = account.collaborators.last
      expect(collaborator.name).to eq("Hawa Mama")
      expect(collaborator.email).to eq("hawa@example.com")
      expect(collaborator.role).to eq("owner")
      expect(collaborator.joined_at).to eq(nil)
    end
  end

  context "when the user is already registered" do
    it "invites the collaborator without creating a new user record" do
      user = create(:user)
      invitable_user = described_class.new(name: user.name, email: user.email, role: "editor")

      expect do
        invitable_user.invite
      end.to change { account.collaborators.count }.by(1) && change(User, :count).by(0)

      collaborator = account.collaborators.last
      expect(collaborator.name).to eq(user.name)
      expect(collaborator.email).to eq(user.email)
      expect(collaborator.role).to eq("editor")
      expect(collaborator.joined_at).to eq(nil)
    end
  end

  context "when the request is invalid" do
    it "returns an error" do
      invitable_user = described_class.new(name: "", email: "", role: "invalid")
      invitable_user.invite

      expect(invitable_user.errors[:name]).to be_present
      expect(invitable_user.errors[:email]).to be_present
      expect(invitable_user.errors[:role]).to be_present
    end
  end

  context "when the collaborator is already present in the account" do
    it "returns an error" do
      user = create(:user)
      create(:collaborator, user: user, account: account)
      invitable_user = described_class.new(name: user.name, email: user.email, role: "owner")
      invitable_user.invite

      expect(invitable_user.errors[:email]).to be_present
    end
  end
end
