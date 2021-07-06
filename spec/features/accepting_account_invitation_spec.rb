require "rails_helper"

RSpec.describe "AcceptingAccountInvitations", type: :feature do
  let(:account) { create(:account) }

  before do
    switch_account(account)
  end

  context "when being a new user of Feature Flow" do
    let(:collaborator) { create(:collaborator, :pending, account: account) }

    it "successfully accepts the invitation" do
      visit invitation_path(collaborator.token)
      expect(page).to have_text(account.name)

      click_link("Make a new login")
      fill_in "Full name", with: "Hawa"
      fill_in "Email address", with: collaborator.email
      fill_in "Password", with: "examplepassword"
      click_button "Join"

      expect(page).to have_current_path(dashboard_path(script_name: "/#{account.id}"))
    end
  end

  context "when being an existing user of Feature Flow" do
    let(:collaborator) { create(:collaborator, :pending, account: account) }
    let(:user) { create(:user) }

    it "successfully accepts the invitation" do
      visit invitation_path(collaborator.token)
      click_link("Link with")
      fill_in "Email address", with: user.email
      fill_in "Password", with: user.password
      click_button "Join"

      expect(page).to have_current_path(dashboard_path(script_name: "/#{account.id}"))
    end
  end

  context "when user has forgotten their password" do
    let(:collaborator) { create(:collaborator, :pending, account: account) }
    let(:return_url) { invitation_url(collaborator.token, subdomain: "app", script_name: "/#{account.id}") }
    let(:user) { create(:user) }

    it "resets the password and accepts the invitation" do
      visit invitation_path(collaborator.token)
      click_link("Link with")
      click_link("Forgot")
      expect(page).to have_current_path(new_password_reset_path(return_url: return_url))

      visit edit_password_reset_path(user.signed_id(purpose: :password_reset), return_url: return_url)
      fill_in "Password", with: "example"
      fill_in "Password confirmation", with: "example"
      click_button "Reset"

      expect(page).to have_current_path(invitation_url(collaborator.token, subdomain: "app", script_name: "/#{account.id}"))
      expect(page).to have_text(account.name)
    end
  end
end
