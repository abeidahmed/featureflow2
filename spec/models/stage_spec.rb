require "rails_helper"

RSpec.describe Stage, type: :model do
  subject(:stage) { build(:stage) }

  describe "associations" do
    it { is_expected.to belong_to(:account) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_length_of(:name).is_at_most(30) }

    it { is_expected.to allow_value("#000", "#1f1f1F", "").for(:color) }

    it { is_expected.not_to allow_value("#F0h", "#afaf", "1f1#1F", "0000").for(:color) }
  end

  describe "callbacks" do
    context "when color is not provided" do
      it "sets up the default value for color" do
        stage.color = nil
        stage.save!

        stage.reload
        expect(stage.color).to eq("#24292e")
      end
    end

    context "when color is provided" do
      it "does not set the default color" do
        hex_color = "#CBD5E1"
        stage.color = hex_color.upcase
        stage.save!

        stage.reload
        expect(stage.color).to eq(hex_color.downcase)
      end
    end
  end

  describe ".order_by_position" do
    it "orders the stages by its asc position" do
      stage3 = create(:stage, position: 3)
      stage1 = create(:stage, position: 1)
      stage2 = create(:stage, position: 2)

      expect(described_class.order_by_position.ids).to eq([stage1.id, stage2.id, stage3.id])
    end
  end
end
