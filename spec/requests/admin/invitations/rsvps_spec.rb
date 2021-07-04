require "rails_helper"

RSpec.describe "Admin::Invitations::Rsvps", type: :request do
  let(:account) { create(:account) }

  before do
    switch_account(account)
  end

  describe "#new" do
    context "when collaborator has a pending invite" do
      it "renders the show template" do
        collaborator = create(:collaborator, :pending, account: account)
        get new_invitation_rsvp_path(collaborator.token)

        expect(response).to render_template(:new)
      end
    end

    context "when collaborator has an invalid invite token" do
      it "renders the not found template" do
        get new_invitation_rsvp_path("invalid-token")

        expect(response).to render_template(:not_found)
      end
    end

    context "when collaborator has already accepted the invitation" do
      it "redirects to their account" do
        collaborator = create(:collaborator, account: account)
        get new_invitation_rsvp_path(collaborator.token)

        expect(response).to redirect_to(dashboard_path(script_name: "/#{collaborator.account.id}"))
      end
    end

    context "when account is misused" do
      it "renders the not found template" do
        another_account = create(:account)
        switch_account(another_account)
        collaborator = create(:collaborator, :pending, account: account)
        get new_invitation_rsvp_path(collaborator.token)

        expect(response).to render_template(:not_found)
      end
    end
  end

  describe "#edit" do
    context "when collaborator has a pending invite" do
      it "renders the show template" do
        collaborator = create(:collaborator, :pending, account: account)
        get edit_invitation_rsvp_path(collaborator.token)

        expect(response).to render_template(:edit)
      end
    end

    context "when collaborator has an invalid invite token" do
      it "renders the not found template" do
        get edit_invitation_rsvp_path("invalid-token")

        expect(response).to render_template(:not_found)
      end
    end

    context "when collaborator has already accepted the invitation" do
      it "redirects to their account" do
        collaborator = create(:collaborator, account: account)
        get edit_invitation_rsvp_path(collaborator.token)

        expect(response).to redirect_to(dashboard_path(script_name: "/#{collaborator.account.id}"))
      end
    end

    context "when account is misused" do
      it "renders the not found template" do
        another_account = create(:account)
        switch_account(another_account)
        collaborator = create(:collaborator, :pending, account: account)
        get edit_invitation_rsvp_path(collaborator.token)

        expect(response).to render_template(:not_found)
      end
    end
  end
end
