require "rails_helper"

RSpec.describe "Admin::Collaborators::Revocations", type: :request do
  let(:user) { create(:user) }
  let(:account) { create(:account) }

  before do
    switch_account(account)
    sign_in(user)
  end

  describe "#show" do
    context "when there is only one owner and editor tries to leave" do
      it "renders the show action" do
        editor = create(:collaborator, account: account, user: user)
        create(:collaborator, :owner, account: account)
        get collaborator_revocations_path(editor)

        expect(response).to render_template(:show)
      end
    end

    context "when there is only one owner and owner tries to leave" do
      it "renders the revocation template" do
        owner = create(:collaborator, :owner, account: account, user: user)
        get collaborator_revocations_path(owner)

        expect(response).to render_template(:not_allowed)
      end
    end

    context "when there are two owners and one of them tries to leave" do
      it "renders the show action" do
        another_owner = create(:collaborator, :owner, account: account, user: user)
        create(:collaborator, :owner, account: account)
        get collaborator_revocations_path(another_owner)

        expect(response).to render_template(:show)
      end
    end
  end
end
