require "rails_helper"

RSpec.describe StagePolicy, type: :policy do
  subject { described_class.new(user, account) }

  let(:account) { create(:account) }

  context "when being an owner" do
    let(:collaborator) { create(:collaborator, :owner, account: account) }
    let(:user) { collaborator.user }

    it { is_expected.to permit_actions(%i[create update destroy]) }
  end

  context "when being an editor" do
    let(:collaborator) { create(:collaborator, account: account) }
    let(:user) { collaborator.user }

    it { is_expected.to permit_actions(%i[create update destroy]) }
  end

  context "when being a pending collaborator" do
    let(:collaborator) { create(:collaborator, :pending, :owner, account: account) }
    let(:user) { collaborator.user }

    it { is_expected.to forbid_actions(%i[create update destroy]) }
  end
end
