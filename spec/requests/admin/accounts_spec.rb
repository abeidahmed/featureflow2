require "rails_helper"

RSpec.describe "Admin::Accounts", type: :request do
  describe "#create" do
    let(:user) { create(:user) }

    before do
      switch_account
      sign_in(user)
    end

    context "when the request is valid" do
      let(:valid_attributes) { { name: "Example account", subdomain: "example" } }

      it "creates an account" do
        expect do
          post accounts_path, params: { account: valid_attributes }
        end.to change(Account, :count).by(1)

        expect(response).to redirect_to(dashboard_path(script_name: "/#{Account.first.id}"))
      end

      it "assigns the current_user as the account creator" do
        post accounts_path, params: { account: valid_attributes }

        expect(Account.first.creator).to eq(user)
      end

      it "creates a membership record and assigns the user as owner" do
        Timecop.freeze(Time.zone.today) do
          post accounts_path, params: { account: valid_attributes }

          collaborator = user.collaborators.first
          expect(collaborator.account).to eq(Account.first)
          expect(collaborator.role).to eq("owner")
          expect(collaborator.joined_at).to eq(Time.zone.now)
        end
      end
    end

    context "when the request is invalid" do
      it "does not create an account" do
        expect do
          post accounts_path, params: { account: { name: "Example account", subdomain: "" } }
        end.not_to change(Account, :count)
      end

      it "returns an error" do
        post accounts_path, params: { account: { name: "Example account", subdomain: "" } }

        expect(json.dig(:errors, :subdomain)).to be_present
      end
    end
  end

  describe "#destroy" do
    let(:user) { create(:user) }
    let(:account) { create(:account) }

    before do
      switch_account(account)
      sign_in(user)
    end

    it "deletes the account" do
      create(:collaborator, :owner, user: user, account: account)

      expect do
        delete accounts_path
      end.to change(Account, :count).by(-1)

      expect(response).to redirect_to(accounts_path(script_name: nil))
    end
  end
end
