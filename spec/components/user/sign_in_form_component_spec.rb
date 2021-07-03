require "rails_helper"

RSpec.describe User::SignInFormComponent, type: :component do
  it "renders the form" do
    render_inline(described_class.new(url: sessions_path))

    expect(rendered_component).to have_selector("form[action='#{sessions_path}']")
    expect(rendered_component).to have_selector("input[name='email']")
    expect(rendered_component).to have_selector("input[name='password']")
    expect(rendered_component).to have_selector("input[type='submit']")
    expect(rendered_component).to have_link("Forgot your password", href: new_password_reset_path)
  end
end
