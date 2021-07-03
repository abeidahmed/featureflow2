require "rails_helper"

RSpec.describe "Admin::Accounts", type: :request do
  before do
    host! "app.example.com"
  end

  describe "#create" do
    let(:user) { create(:user) }

    before do
      sign_in(user)
    end

    context "when the request is valid" do
      let(:valid_attributes) { { name: "Example account", subdomain: "example" } }

      it "creates an account" do
        expect do
          post accounts_path, params: { account: valid_attributes }
        end.to change(Account, :count).by(1)
      end

      it "assigns the current_user as the account creator" do
        post accounts_path, params: { account: valid_attributes }

        expect(Account.first.creator).to eq(user)
      end
    end

    context "when the request is invalid" do
      it "returns an error" do
        post accounts_path, params: { account: { name: "Example account", subdomain: "" } }

        expect(json.dig(:errors, :subdomain)).to be_present
      end
    end
  end
end
