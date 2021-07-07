require "rails_helper"

RSpec.describe Stage::ListComponent, type: :component do
  it "renders the name" do
    stage = create(:stage)
    render_inline(described_class.new(stage: stage))

    expect(rendered_component).to have_selector("h2", text: stage.name)
    expect(rendered_component).to match(/style="color: #{stage.color};"/)
  end
end
