require "rails_helper"

RSpec.describe "PasswordResets", type: :request do
  before do
    host! "app.example.com"
  end

  describe "#create" do
    context "when the email is valid" do
      it "sends a password reset email" do
        user = create(:user)

        Timecop.freeze(Time.zone.now) do
          sgid = user.signed_id(expires_in: 2.hours, purpose: :password_reset)
          allow(UserMailer).to receive(:with).and_call_original
          post password_resets_path, params: { user: { email: user.email.upcase } }

          expect(UserMailer).to have_received(:with).with(user: user, sgid: sgid)
          expect(response).to redirect_to(password_reset_path(sgid))
        end
      end
    end

    context "when the email is invalid" do
      it "returns an error" do
        post password_resets_path, params: { user: { email: "invalid@example.com" } }

        expect(json.dig(:errors, :invalid)).to be_present
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "#show" do
    let(:user) { create(:user) }

    context "when the signed_id is valid" do
      it "renders the show action" do
        get password_reset_path(user.signed_id(expires_in: 2.hours, purpose: :password_reset))

        expect(response).to render_template(:show)
      end
    end

    context "when the signed_id has expired" do
      it "redirects to password reset path" do
        sgid = user.signed_id(expires_in: 2.hours, purpose: :password_reset)
        Timecop.travel(3.hours)
        get password_reset_path(sgid)

        expect(response).to render_template(:not_found)
      end
    end

    context "when the signed_id is invalid" do
      it "redirects to password reset path" do
        sgid = user.signed_id(expires_in: 2.hours, purpose: :invalid)
        get password_reset_path(sgid)

        expect(response).to render_template(:not_found)
      end
    end
  end

  describe "#edit" do
    let(:user) { create(:user) }

    context "when the signed_id is valid" do
      it "renders the edit action" do
        get edit_password_reset_path(user.signed_id(expires_in: 2.hours, purpose: :password_reset))

        expect(response).to render_template(:edit)
      end
    end

    context "when the signed_id has expired" do
      it "redirects to password reset path" do
        sgid = user.signed_id(expires_in: 2.hours, purpose: :password_reset)
        Timecop.travel(3.hours)
        get edit_password_reset_path(sgid)

        expect(response).to render_template(:not_found)
      end
    end

    context "when the signed_id is invalid" do
      it "redirects to password reset path" do
        sgid = user.signed_id(expires_in: 2.hours, purpose: :invalid)
        get edit_password_reset_path(sgid)

        expect(response).to render_template(:not_found)
      end
    end
  end

  describe "#update" do
    context "when the request is valid" do
      it "resets the password" do
        user = create(:user)
        sgid = user.signed_id(expires_in: 2.hours, purpose: :password_reset)
        patch password_reset_path(sgid), params: { user: { password: "mamakane", password_confirmation: "mamakane" } }

        user.reload
        expect(user.authenticate("mamakane")).to eq(user)
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "when request is invalid" do
      let(:user) { create(:user) }
      let(:sgid) { user.signed_id(expires_in: 2.hours, purpose: :password_reset) }

      before do
        patch password_reset_path(sgid), params: { user: { password: "mamakane", password_confirmation: "MAMAKANE" } }
      end

      it "does not reset the password" do
        user.reload
        expect(user.authenticate("mamakane")).to be_falsy
      end

      it "returns an error" do
        expect(json.dig(:errors, :password_confirmation)).to be_present
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
