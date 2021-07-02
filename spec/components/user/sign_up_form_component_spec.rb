require "rails_helper"

RSpec.describe User::SignUpFormComponent, type: :component do
  it "renders the form" do
    render_inline(described_class.new(model: User.new))

    expect(rendered_component).to have_selector("form[action='#{users_path}']")
    expect(rendered_component).to have_selector("input[name='user[name]']")
    expect(rendered_component).to have_selector("input[name='user[email]']")
    expect(rendered_component).to have_selector("input[name='user[password]']")
    expect(rendered_component).to have_selector("input[type='submit']")
  end
end
