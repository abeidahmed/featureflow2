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
          post password_resets_path, params: { email: user.email }

          expect(UserMailer).to have_received(:with).with(user: user, sgid: sgid)
          expect(response).to redirect_to(password_reset_path(sgid))
        end
      end
    end

    context "when the email is invalid" do
      it "returns an error" do
        post password_resets_path, params: { email: "invalid@example.com" }

        expect(json.dig(:errors, :invalid)).to be_present
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
