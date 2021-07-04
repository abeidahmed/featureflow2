require "rails_helper"

RSpec.describe "Admin::Invitations", type: :request do
  let(:account) { create(:account) }

  before do
    switch_account(account)
  end

  describe "#show" do
    context "when collaborator has a pending invite" do
      it "renders the show template" do
        collaborator = create(:collaborator, :pending, account: account)
        get invitation_path(collaborator.token)

        expect(response).to render_template(:show)
      end
    end

    context "when collaborator has an invalid invite token" do
      it "renders the not found template" do
        get invitation_path("invalid-token")

        expect(response).to render_template(:not_found)
      end
    end

    context "when collaborator has already accepted the invitation" do
      it "redirects to their account" do
        collaborator = create(:collaborator, account: account)
        get invitation_path(collaborator.token)

        expect(response).to redirect_to(dashboard_path(script_name: "/#{collaborator.account.id}"))
      end
    end

    context "when account is misused" do
      it "renders the not found template" do
        another_account = create(:account)
        switch_account(another_account)
        collaborator = create(:collaborator, :pending, account: account)
        get invitation_path(collaborator.token)

        expect(response).to render_template(:not_found)
      end
    end
  end
end
