require "rails_helper"

RSpec.describe "AccountExits", type: :feature do
  let(:account) { create(:account) }
  let(:owner) { create(:collaborator, :owner, account: account) }
  let(:editor) { create(:collaborator, account: account) }

  before do
    switch_account(account)
  end

  context "when collaborator can leave" do
    before do
      sign_in(editor.user)
      visit collaborator_revocations_path(editor)
    end

    it "has the back link" do
      expect(page).to have_link("I'll stay", href: setting_collaborators_path(script_name: "/#{account.id}"))
    end

    it "can exit the team" do
      click_button "exit"

      expect(page).to have_current_path(accounts_path(script_name: nil))
    end
  end

  context "when collaborator cannot leave" do
    before do
      sign_in(owner.user)
      visit collaborator_revocations_path(owner)
    end

    it "has the back link" do
      expect(page).to have_link("I'll stay", href: setting_collaborators_path(script_name: "/#{account.id}"))
    end

    it "has the delete account button" do
      click_button "Delete account"

      expect(page).to have_current_path(accounts_path(script_name: nil))
    end
  end
end
