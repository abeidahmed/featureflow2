require "rails_helper"

RSpec.describe Collaborator::RolifyComponent, type: :component do
  it "renders the form" do
    collaborator = create(:collaborator, :owner)
    render_inline(described_class.new(collaborator: collaborator, current_user: collaborator.user))

    expect(rendered_component).to have_selector("form[action='#{collaborator_path(collaborator)}']")
  end

  context "when being the owner and the current_user" do
    let(:collaborator) { create(:collaborator, :owner) }

    before do
      render_inline(described_class.new(collaborator: collaborator, current_user: collaborator.user))
    end

    it "renders the title" do
      expect(rendered_component).to have_text("Demote yourself")
    end

    it "renders the demote myself button" do
      expect(rendered_component).to have_button("Demote myself")
    end

    it "renders the btn--danger class on the button" do
      expect(rendered_component).to have_css("input[type='submit'].btn--danger")
    end
  end

  context "when being the owner but not the current_user" do
    let(:collaborator) { create(:collaborator, :owner) }
    let(:user) { create(:user) }

    before do
      render_inline(described_class.new(collaborator: collaborator, current_user: user))
    end

    it "renders the title" do
      expect(rendered_component).to have_text("Demote #{user.name}")
    end

    it "renders the btn--danger class on the button" do
      expect(rendered_component).to have_css("input[type='submit'].btn--danger")
    end
  end

  context "when being the collaborator" do
    let(:collaborator) { create(:collaborator) }

    before do
      render_inline(described_class.new(collaborator: collaborator, current_user: collaborator.user))
    end

    it "renders the title" do
      expect(rendered_component).to have_text("Promote #{collaborator.name}")
    end

    it "renders the btn--primary class on the button" do
      expect(rendered_component).to have_css("input[type='submit'].btn--primary")
    end
  end
end
