require "rails_helper"

RSpec.describe SubheadComponent, type: :component do
  context "when heading is present" do
    it "renders the component" do
      render_inline(described_class.new) do |c|
        c.heading { "hello world" }
      end

      expect(rendered_component).to have_css("div.subhead")
      expect(rendered_component).to have_selector("h2.subhead-heading", text: "hello world")
      expect(rendered_component).not_to have_css("h2.subhead-heading--danger")
    end

    it "renders the danger variant" do
      render_inline(described_class.new) do |c|
        c.heading(variant: "danger") { "hello world" }
      end

      expect(rendered_component).to have_selector("h2.subhead-heading--danger", text: "hello world")
    end

    it "renders the subhead description" do
      render_inline(described_class.new) do |c|
        c.heading(variant: "danger") { "hello world" }
        c.description { "My description" }
      end

      expect(rendered_component).to have_selector("div.subhead-description", text: "My description")
    end
  end

  context "when heading is absent" do
    it "does not render the component" do
      render_inline(described_class.new)

      expect(rendered_component).to be_blank
    end
  end
end
