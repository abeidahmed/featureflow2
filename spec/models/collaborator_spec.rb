require "rails_helper"

RSpec.describe Collaborator, type: :model do
  subject(:collaborator) { build(:collaborator) }

  describe "associations" do
    it { is_expected.to belong_to(:account) }

    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    it { is_expected.to validate_uniqueness_of(:user).scoped_to(:account_id).with_message("is already in the account") }

    it { is_expected.to define_enum_for(:role).with_values(owner: "owner", editor: "editor").backed_by_column_of_type(:string) }
  end

  describe "callbacks" do
    it "registers a new token" do
      collaborator = create(:collaborator, token: nil)

      expect(collaborator.token).to be_present
    end
  end
end
