require "rails_helper"

RSpec.describe "Admin::Collaborators::Roles", type: :request do
  let(:user) { create(:user) }
  let(:account) { create(:account) }

  before do
    switch_account(account)
    sign_in(user)
  end

  describe "#show" do
    it "lists the collaborator" do
      create(:collaborator, :owner, account: account, user: user)
      editor = create(:collaborator, account: account)
      get collaborator_roles_path(editor)

      expect(assigns(:collaborator)).to eq(editor)
    end
  end
end
