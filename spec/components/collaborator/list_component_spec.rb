require "rails_helper"

RSpec.describe Collaborator::ListComponent, type: :component do
  it "renders the collaborator info" do
    collaborator = create(:collaborator)
    render_inline(described_class.new(collaborator: collaborator, current_user: collaborator.user))

    expect(rendered_component).to have_selector("h3", text: collaborator.name)
    expect(rendered_component).to have_selector("p", text: collaborator.email)
    expect(rendered_component).to have_css("div##{dom_id(collaborator)}")
  end

  context "when invitation has been accepted" do
    it "does not render the pending tooltip" do
      collaborator = create(:collaborator)
      render_inline(described_class.new(collaborator: collaborator, current_user: collaborator.user))

      expect(rendered_component).not_to have_selector("span[aria-label='Pending invite']")
    end
  end

  context "when invitation is pending" do
    it "renders the pending tooltip" do
      collaborator = create(:collaborator, :pending)
      render_inline(described_class.new(collaborator: collaborator, current_user: collaborator.user))

      expect(rendered_component).to have_selector("span[aria-label='Pending invite']")
    end
  end

  context "when being the collaborator" do
    it "renders the appropriate actions" do
      collaborator = create(:collaborator)
      render_inline(described_class.new(collaborator: collaborator, current_user: collaborator.user))

      expect(rendered_component).to have_link("Remove yourself")
    end
  end
end
