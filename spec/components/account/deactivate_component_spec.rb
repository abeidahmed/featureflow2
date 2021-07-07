require "rails_helper"

RSpec.describe Account::DeactivateComponent, type: :component do
  let(:account) { create(:account) }

  before do
    Current.account = account
  end

  after do
    Current.account = nil
  end

  context "when the account is active" do
    it "renders the confirmable input field" do
      render_inline(described_class.new)

      expect(rendered_component).to have_selector("[data-confirmable-confirm-value='#{account.name}']", visible: :hidden)
      expect(rendered_component).to have_selector("input[data-confirmable-target='inputField']", visible: :hidden)
    end

    it "renders the submit button" do
      render_inline(described_class.new)

      expect(rendered_component).to have_selector("form[action='#{account_statuses_path}']", visible: :hidden)
      expect(rendered_component).to have_selector("input[type='submit']", visible: :hidden)
    end
  end

  context "when the account is inactive" do
    it "does not render when account is inactive" do
      account.inactive!
      render_inline(described_class.new)

      expect(rendered_component).to be_blank
    end
  end
end
