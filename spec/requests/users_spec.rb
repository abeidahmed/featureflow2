require "rails_helper"

RSpec.describe "Users", type: :request do
  let(:valid_attributes) { { name: "John Doe", email: "john@example.com", password: "secretpass" } }
  let(:invalid_attributes) { { name: "John Doe", email: "", password: "secretpass" } }

  before do
    host! "app.example.com"
  end

  describe "#create" do
    context "when the request is valid" do
      it "creates the user" do
        expect do
          post users_path, params: { user: valid_attributes }
        end.to change(User, :count).by(1)
      end

      it "stores the auth_token in the cookie" do
        post users_path, params: { user: valid_attributes }

        expect(signed_cookie[:auth_token]).to eq(User.first.auth_token)
      end
    end

    context "when the request is invalid" do
      it "returns an error" do
        post users_path, params: { user: invalid_attributes }

        expect(json.dig(:errors, :email)).to be_present
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
