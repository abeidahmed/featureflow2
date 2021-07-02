require "rails_helper"

RSpec.describe Template::SlateComponent, type: :component do
  it "renders the component" do
    render_inline(described_class.new) do |c|
      c.heading { "this is the heading" }
      c.body { "this is the body" }
      c.footer { "this is the footer" }
    end

    expect(rendered_component).to have_selector("h1", text: "this is the heading")
    expect(rendered_component).to have_selector("div", text: "this is the body")
    expect(rendered_component).to have_selector("div", text: "this is the footer")
  end
end
