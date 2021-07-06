require "rails_helper"

RSpec.describe AccountPolicy, type: :policy do
  describe "user authentication" do
    subject(:account_policy) { described_class.new(user, account) }

    context "when being a logged in user" do
      let(:user) { create(:user) }
      let(:account) { Account.new }

      it { is_expected.to permit_actions(%i[create]) }
    end

    context "when being a guest" do
      let(:user) { nil }
      let(:account) { Account.new }

      it "raises an error" do
        expect { account_policy }.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end

  context "when being an owner" do
    subject { described_class.new(collaborator.user, collaborator.account) }

    let(:collaborator) { create(:collaborator, :owner) }

    it { is_expected.to permit_actions(%i[update destroy]) }
  end

  context "when being an editor" do
    subject { described_class.new(collaborator.user, collaborator.account) }

    let(:collaborator) { create(:collaborator) }

    it { is_expected.to forbid_actions(%i[update destroy]) }
  end

  context "when being a pending collaborator" do
    subject { described_class.new(collaborator.user, collaborator.account) }

    let(:collaborator) { create(:collaborator, :pending, :owner) }

    it { is_expected.to forbid_actions(%i[update destroy]) }
  end
end
