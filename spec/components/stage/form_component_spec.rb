require "rails_helper"

RSpec.describe Stage::FormComponent, type: :component do
  it "renders the form" do
    render_inline(described_class.new(model: Stage.new))

    expect(rendered_component).to have_selector("form[action='#{stages_path}']")
    expect(rendered_component).to have_selector("input[name='stage[name]']")
    expect(rendered_component).to have_selector("input[name='stage[color]']")
  end
end
