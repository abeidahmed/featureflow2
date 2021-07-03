require "rails_helper"

RSpec.describe AccountPolicy, type: :policy do
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
