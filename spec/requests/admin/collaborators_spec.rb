require "rails_helper"

RSpec.describe "Admin::Collaborators", type: :request do
  let(:user) { create(:user) }
  let(:account) { create(:account) }

  before do
    switch_account(account)
    sign_in(user)
  end

  describe "#create" do
    context "when the request is valid" do
      it "invites the user" do
        create(:collaborator, :owner, user: user, account: account)

        expect do
          post collaborators_path, params: { collaborator: { name: "Hawa", email: "hawa@example.com", role: "editor" } }
        end.to change { account.collaborators.count }.by(1)
      end
    end

    context "when the request is invalid" do
      it "returns an error" do
        create(:collaborator, :owner, user: user, account: account)
        post collaborators_path, params: { collaborator: { name: "", email: "", role: "editor" } }

        expect(json.dig(:errors, :name)).to be_present
        expect(json.dig(:errors, :email)).to be_present
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "#destroy" do
    context "when there is only one owner in the team" do
      it "does not remove the current owner" do
        collaborator = create(:collaborator, :owner, user: user, account: account)
        create(:collaborator, account: account)

        expect do
          delete collaborator_path(collaborator)
        end.not_to change { account.collaborators.count }

        expect(response).to have_http_status(:forbidden)
      end
    end

    context "when request is valid" do
      it "removes the user" do
        collaborator = create(:collaborator, user: user, account: account)
        create(:collaborator, :owner, account: account)

        expect do
          delete collaborator_path(collaborator)
        end.to change { account.collaborators.count }.by(-1)
      end
    end
  end
end
