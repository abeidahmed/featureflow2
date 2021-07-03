require "rails_helper"

RSpec.describe User::PasswordResetEditFormComponent, type: :component do
  it "renders the form" do
    user = create(:user)
    render_inline(described_class.new(model: user, url: password_reset_path(user)))

    expect(rendered_component).to have_selector("form[action='#{password_reset_path(user)}']")
    expect(rendered_component).to have_selector("input[name='user[password]']")
    expect(rendered_component).to have_selector("input[name='user[password_confirmation]']")
    expect(rendered_component).to have_selector("input[type='submit']")
  end
end
