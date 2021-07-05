require "rails_helper"

RSpec.describe Collaborator::InviteFormComponent, type: :component do
  context "when being an editor" do
    it "does not render the component" do
      collaborator = create(:collaborator)
      render_inline(described_class.new(current_user: collaborator.user, account: collaborator.account))

      expect(rendered_component).to be_blank
    end
  end

  context "when being an owner" do
    let(:collaborator) { create(:collaborator, :owner) }

    before do
      render_inline(described_class.new(current_user: collaborator.user, account: collaborator.account))
    end

    it "renders the component" do
      expect(rendered_component).to have_selector("summary", text: "Invite")
    end

    it "renders the form" do
      expect(rendered_component).to have_selector("form[action='#{collaborators_path}']", visible: :hidden)
      expect(rendered_component).to have_selector("input[name='collaborator[name]']", visible: :hidden)
      expect(rendered_component).to have_selector("input[name='collaborator[email]']", visible: :hidden)
      expect(rendered_component).to have_selector("input[name='collaborator[role]']", visible: :hidden)
      expect(rendered_component).to have_selector("input[value='editor'][checked='checked']", visible: :hidden)
      expect(rendered_component).to have_selector("input[value='owner']", visible: :hidden)
      expect(rendered_component).to have_selector("input[type='submit']", visible: :hidden)
    end
  end
end
