require "rails_helper"

RSpec.describe User::PasswordResetNewFormComponent, type: :component do
  it "renders the component" do
    render_inline(described_class.new(model: User.new, url: password_resets_path))

    expect(rendered_component).to have_selector("form[action='#{password_resets_path}']")
    expect(rendered_component).to have_selector("input[name='user[email]']")
    expect(rendered_component).to have_selector("input[type='submit']")
  end
end
