require "rails_helper"

RSpec.describe PopoverComponent, type: :component do
  it "renders the component" do
    render_inline(described_class.new) do |c|
      c.body { "hello world" }
    end

    expect(rendered_component).to have_css("div.popover")
    expect(rendered_component).to have_text("hello world")
  end

  context "when position is not given" do
    it "adds the top_left class" do
      render_inline(described_class.new) do |c|
        c.body { "hello world" }
      end

      expect(rendered_component).to have_css("div.popover-message--top-left")
    end
  end

  context "when valid position is given" do
    it "adds the position class" do
      render_inline(described_class.new) do |c|
        c.body(caret: :bottom) { "hello world" }
      end

      expect(rendered_component).to have_css("div.popover-message--bottom")
    end
  end

  context "when invalid position is given" do
    it "adds the top_left class" do
      render_inline(described_class.new) do |c|
        c.body(caret: :invalid) { "hello world" }
      end

      expect(rendered_component).to have_css("div.popover-message--top-left")
    end
  end
end
