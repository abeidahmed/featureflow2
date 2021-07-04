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

  describe "#create" do
    context "when the request is valid" do
      let(:collaborator) { create(:collaborator, :pending, account: account) }
      let(:valid_attributes) { { name: "Hawa", email: collaborator.email, password: "hellothere" } }

      it "accepts the invitation" do
        Timecop.freeze(Time.zone.today) do
          post invitation_rsvp_path(collaborator.token), params: { collaborator: valid_attributes }
          token = collaborator.token

          collaborator.reload
          collaborator.user.reload
          expect(collaborator.joined_at).to eq(Time.zone.now)
          expect(collaborator.name).to eq("Hawa")
          expect(collaborator.user.authenticate("hellothere")).to eq(collaborator.user)
          expect(collaborator.token).not_to eq(token)
          expect(response).to redirect_to(dashboard_path)
        end
      end

      it "creates a new session for the collaborator" do
        post invitation_rsvp_path(collaborator.token), params: { collaborator: valid_attributes }

        expect(signed_cookie[:auth_token]).to eq(collaborator.user.auth_token)
      end
    end

    context "when the request is invalid" do
      let(:collaborator) { create(:collaborator, :pending, account: account) }

      it "returns an error" do
        post invitation_rsvp_path(collaborator.token), params: { collaborator: { email: collaborator.email, password: "" } }

        expect(json.dig(:errors, :password)).to be_present
      end
    end

    context "when collaborator has already accepted the invite" do
      let(:collaborator) { create(:collaborator, account: account) }

      it "raises an error" do
        expect do
          post invitation_rsvp_path(collaborator.token), params: { collaborator: { email: collaborator.email, password: "" } }
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "when account is misused" do
      let(:new_account) { create(:account) }
      let(:collaborator) { create(:collaborator, :pending, account: account) }

      it "raises an error" do
        switch_account(new_account)

        expect do
          post invitation_rsvp_path(collaborator.token), params: { collaborator: { email: "hawa@example.com", password: "mamakane" } }
        end.to raise_error(ActiveRecord::RecordNotFound)
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
