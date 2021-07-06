require "rails_helper"

RSpec.describe CollaboratorPolicy, type: :policy do
  subject { described_class.new(user, collaborator) }

  let(:account) { create(:account) }

  describe "targeting self" do
    context "when being an owner" do
      let(:user) { create(:user) }
      let(:collaborator) { create(:collaborator, :owner, user: user) }

      it { is_expected.to permit_actions(%i[create]) }
    end

    context "when being an editor" do
      let(:user) { create(:user) }
      let(:collaborator) { create(:collaborator, user: user) }

      it { is_expected.to forbid_actions(%i[create]) }
    end

    context "when being a pending member" do
      let(:user) { create(:user) }
      let(:collaborator) { create(:collaborator, :owner, :pending, user: user) }

      it { is_expected.to forbid_actions(%i[create]) }
    end

    context "when being the current collaborator" do
      let(:user) { create(:user) }
      let(:collaborator) { create(:collaborator, user: user) }

      it { is_expected.to permit_actions(%i[destroy]) }
    end
  end

  describe "targeting other collaborators" do
    context "when being an owner" do
      let(:owner) { create(:collaborator, :owner, account: account) }
      let(:collaborator) { create(:collaborator, account: account) }
      let(:user) { collaborator.user }

      it { is_expected.to permit_actions(%i[destroy]) }
    end

    context "when being an editor" do
      let(:collaborator) { create(:collaborator, account: account) }
      let(:user) { current_collaborator.user }
      let(:current_collaborator) { create(:collaborator, account: account) }

      it { is_expected.to forbid_actions(%i[destroy]) }
    end

    context "when being a pending member" do
      let(:owner) { create(:collaborator, :owner, :pending, account: account) }
      let(:user) { owner.user }
      let(:collaborator) { create(:collaborator, account: account) }

      it { is_expected.to forbid_actions(%i[destroy]) }
    end
  end

  describe "rolify" do
    context "when being an owner" do
      let(:owner) { create(:collaborator, :owner, account: account) }
      let(:user) { owner.user }
      let(:collaborator) { create(:collaborator, account: account) }

      it { is_expected.to permit_actions(%i[rolify]) }
    end

    context "when being an editor" do
      let(:editor) { create(:collaborator, account: account) }
      let(:user) { editor.user }
      let(:collaborator) { create(:collaborator, account: account) }

      it { is_expected.to forbid_actions(%i[rolify]) }
    end

    context "when being a pending member" do
      let(:owner) { create(:collaborator, :pending, :owner, account: account) }
      let(:user) { owner.user }
      let(:collaborator) { create(:collaborator, account: account) }

      it { is_expected.to forbid_actions(%i[rolify]) }
    end

    context "when being a single owner and trying to demote itself" do
      let(:collaborator) { create(:collaborator, :owner, account: account) }
      let(:user) { collaborator.user }

      before { collaborator.reload }

      it { is_expected.to forbid_actions(%i[rolify]) }
    end
  end
end
