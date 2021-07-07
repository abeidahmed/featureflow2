require "rails_helper"

RSpec.describe PaginationComponent, type: :component do
  context "when number of pages is more than 1" do
    it "renders the component" do
      accounts = create_list(:account, 5)
      records = Pagy.new(count: accounts.count, items: 4)
      render_inline(described_class.new(records: records))

      expect(rendered_component).to have_selector("div")
    end
  end

  context "when number of pages is less than 1" do
    it "does not render the component" do
      accounts = create_list(:account, 1)
      records = Pagy.new(count: accounts.count, items: 1)
      render_inline(described_class.new(records: records))

      expect(rendered_component).to be_blank
    end
  end
end
