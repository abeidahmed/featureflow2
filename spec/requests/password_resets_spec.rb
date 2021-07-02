require "rails_helper"

RSpec.describe "PasswordResets", type: :request do
  before do
    host! "app.example.com"
  end

  describe "#create" do
    context "when the email is present" do
      it "sends the reset email" do
      end
    end

    context "when the email is absent" do
      it "returns an error" do
        post password_resets_path, params: { email: "invalid@example.com" }

        expect(json.dig(:errors, :invalid)).to be_present
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
