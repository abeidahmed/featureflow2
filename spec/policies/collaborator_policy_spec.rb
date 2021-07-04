require "rails_helper"

RSpec.describe CollaboratorPolicy, type: :policy do
  subject { described_class.new(user, collaborator) }

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
end
