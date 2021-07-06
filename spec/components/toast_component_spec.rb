require "rails_helper"

RSpec.describe ToastComponent, type: :component do
  it "renders the component" do
    render_inline(described_class.new(message: "Good day"))

    expect(rendered_component).to have_selector("div.toast--success")
    expect(rendered_component).to have_selector("p.toast-content", text: "Good day")
    expect(rendered_component).to have_selector("button[data-action='toast#hide']")
    expect(rendered_component).to have_selector("svg")
  end

  it "renders the toast variant" do
    render_inline(described_class.new(message: "Good day", variant: "error"))

    expect(rendered_component).to have_selector("div.toast--error")
  end
end
