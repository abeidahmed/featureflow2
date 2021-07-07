require "rails_helper"

RSpec.describe Stage::FormComponent, type: :component do
  it "renders the form" do
    render_inline(described_class.new(model: Stage.new))

    expect(rendered_component).to have_selector("form[action='#{stages_path}']")
    expect(rendered_component).to have_selector("input[name='stage[name]']")
    expect(rendered_component).to have_selector("input[name='stage[color]']")
  end

  context "when stage is persisted" do
    it "renders the Edit title" do
      stage = create(:stage)
      render_inline(described_class.new(model: stage))

      expect(rendered_component).to have_text("Edit this stage")
    end
  end

  context "when stage is new" do
    it "renders the Add title" do
      render_inline(described_class.new(model: Stage.new))

      expect(rendered_component).to have_text("Add a new stage")
    end
  end
end
