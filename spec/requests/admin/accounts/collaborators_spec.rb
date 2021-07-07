require "rails_helper"

RSpec.describe "Admin::Accounts::Collaborators", type: :request do
  let(:user) { create(:user) }
  let(:account) { create(:account) }

  before do
    switch_account(account)
    sign_in(user)
  end

  describe "#index" do
    context "when requested by a collaborator" do
      it "lists the collaborators of the account" do
        create(:collaborator, user: user, account: account)
        create_list(:collaborator, 5, account: account)
        get account_collaborators_path

        expect(assigns(:collaborators).size).to eq(6)
      end

      it "filters the collaborators" do
        create(:collaborator, user: user, account: account)
        new_user = create(:user, name: "xyz")
        create(:collaborator, user: new_user, account: account)
        get account_collaborators_path, params: { query: "xyz" }

        expect(assigns(:collaborators).size).to eq(1)
      end
    end

    context "when requested by pending collaborator" do
      it "does not list any collaborators" do
        create(:collaborator, :pending, user: user, account: account)
        get account_collaborators_path

        expect(assigns(:collaborators)).to eq(nil)
      end
    end

    context "when requested by a guest" do
      it "does not list any collaborators" do
        create(:collaborator, account: account)
        get account_collaborators_path

        expect(assigns(:collaborators)).to eq(nil)
      end
    end
  end
end
