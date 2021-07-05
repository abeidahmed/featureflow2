require "rails_helper"

RSpec.describe "Admin::Collaborators::Removals", type: :request do
  let(:user) { create(:user) }
  let(:account) { create(:account) }

  before do
    switch_account(account)
    sign_in(user)
  end

  describe "#show" do
    it "lists the collaborator" do
      create(:collaborator, :owner, user: user, account: account)
      collaborator = create(:collaborator, account: account)
      get collaborator_removals_path(collaborator)

      expect(assigns(:collaborator)).to eq(collaborator)
    end
  end
end
