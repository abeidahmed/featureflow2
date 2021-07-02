require "rails_helper"

RSpec.describe Account::NewFormComponent, type: :component do
  it "renders the form" do
    render_inline(described_class.new(model: Account.new))

    expect(rendered_component).to have_selector("form[action='#{accounts_path}']")
    expect(rendered_component).to have_selector("input[name='account[name]']")
    expect(rendered_component).to have_selector("input[name='account[subdomain]']")
    expect(rendered_component).to have_selector("input[type='submit']")
  end
end
