require "rails_helper"

RSpec.describe Form::ErrorComponent, type: :component do
  it "renders the component" do
    render_inline(described_class.new(error_field: :name))

    expect(rendered_component).to have_selector("p[data-hotwire-target='errorContainer']")
    expect(rendered_component).to have_selector("p[data-form-error='name']")
  end
end
