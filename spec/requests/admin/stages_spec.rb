require "rails_helper"

RSpec.describe "Admin::Stages", type: :request do
  let(:user) { create(:user) }
  let(:account) { create(:account) }

  before do
    switch_account(account)
    sign_in(user)
    create(:collaborator, user: user, account: account)
  end

  describe "#create" do
    context "when the request is valid" do
      it "creates a stage" do
        expect do
          post stages_path, params: { stage: { name: "Completed" }, format: :turbo_stream }
        end.to change { account.stages.count }.by(1)

        expect(account.stages.first.color).to be_present
      end
    end

    context "when the request is invalid" do
      it "returns an error" do
        post stages_path, params: { stage: { name: "" } }

        expect(json.dig(:errors, :name)).to be_present
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
