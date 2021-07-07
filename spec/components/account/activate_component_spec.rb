require "rails_helper"

RSpec.describe Account::ActivateComponent, type: :component do
  let(:account) { create(:account) }

  before do
    Current.account = account
  end

  after do
    Current.account = nil
  end

  context "when the account is inactive" do
    it "renders the submit form" do
      account.inactive!
      render_inline(described_class.new)

      expect(rendered_component).to have_selector("form[action='#{account_statuses_path}']")
      expect(rendered_component).to have_selector("input[type='submit']")
    end
  end

  context "when the account is active" do
    it "does not render if account is active" do
      render_inline(described_class.new)

      expect(rendered_component).to be_blank
    end
  end
end
