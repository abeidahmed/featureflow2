require "rails_helper"

RSpec.describe "Admin::Settings::Collaborators", type: :request do
  let(:user) { create(:user) }
  let(:account) { create(:account) }

  before do
    switch_account(account)
    sign_in(user)
  end

  describe "#index" do
    it "lists out the collaborators" do
      create(:collaborator, user: user, account: account)
      create_list(:collaborator, 5, account: account)
      get setting_collaborators_path

      expect(assigns(:collaborators).size).to eq(6)
    end
  end
end
