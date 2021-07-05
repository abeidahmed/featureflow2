require "rails_helper"

RSpec.describe User::PasswordResetNewFormComponent, type: :component do
  it "renders the component" do
    render_inline(described_class.new(model: User.new, url: password_resets_path))

    expect(rendered_component).to have_selector("form[action='#{password_resets_path}']")
    expect(rendered_component).to have_selector("input[name='user[email]']")
    expect(rendered_component).to have_selector("input[type='submit']")
  end

  context "when return_url is not specified" do
    it "does not render the hidden field tag" do
      render_inline(described_class.new(model: User.new, url: password_resets_path))

      expect(rendered_component).not_to have_selector("input[name='return_url']", visible: :hidden)
    end
  end

  context "when return_url is specified" do
    it "renders the hidden field tag" do
      render_inline(described_class.new(model: User.new, url: password_resets_path, return_url: new_user_path))

      expect(rendered_component).to have_selector("input[name='return_url']", visible: :hidden)
    end
  end
end
