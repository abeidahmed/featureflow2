require "rails_helper"

RSpec.describe Account::DeleteComponent, type: :component do
  let(:account) { create(:account) }

  before do
    Current.account = account
  end

  after do
    Current.account = nil
  end

  it "displays the confirmable input field" do
    render_inline(described_class.new)

    expect(rendered_component).to have_selector("[data-confirmable-confirm-value='#{account.name}']", visible: :hidden)
    expect(rendered_component).to have_selector("input[data-confirmable-target='inputField']", visible: :hidden)
  end

  it "displays the submit button" do
    render_inline(described_class.new)

    expect(rendered_component).to have_selector("form[action='#{accounts_path}']", visible: :hidden)
    expect(rendered_component).to have_selector("input[type='submit']", visible: :hidden)
  end
end
