require "rails_helper"

RSpec.describe "Admin::Accounts::Statuses", type: :request do
  let(:account) { create(:account) }
  let(:user) { create(:user) }

  before do
    switch_account(account)
    sign_in(user)
  end

  describe "#update" do
    before do
      create(:collaborator, :owner, user: user, account: account)
    end

    it "redirects to setting root path" do
      patch account_statuses_path

      expect(response).to redirect_to(setting_root_path)
    end

    context "when the account is active" do
      it "deactivates the account" do
        patch account_statuses_path
        account.reload

        expect(account.status).to eq("inactive")
      end
    end

    context "when the account is inactive" do
      it "activates the account" do
        account.inactive!
        patch account_statuses_path
        account.reload

        expect(account.status).to eq("active")
      end
    end
  end
end
