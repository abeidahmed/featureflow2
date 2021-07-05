require "rails_helper"

RSpec.describe User::PasswordResetEditFormComponent, type: :component do
  let(:user) { create(:user) }

  it "renders the form" do
    render_inline(described_class.new(model: user, url: password_reset_path(user)))

    expect(rendered_component).to have_selector("form[action='#{password_reset_path(user)}']")
    expect(rendered_component).to have_selector("input[name='user[password]']")
    expect(rendered_component).to have_selector("input[name='user[password_confirmation]']")
    expect(rendered_component).to have_selector("input[type='submit']")
  end

  context "when return_url is not specified" do
    it "does not render the hidden field tag" do
      render_inline(described_class.new(model: user, url: password_reset_path(user)))

      expect(rendered_component).not_to have_selector("input[name='return_url']", visible: :hidden)
    end
  end

  context "when return_url is specified" do
    it "renders the hidden field tag" do
      render_inline(described_class.new(model: user, url: password_reset_path(user), return_url: new_user_path))

      expect(rendered_component).to have_selector("input[name='return_url']", visible: :hidden)
    end
  end
end
