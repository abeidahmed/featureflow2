require "rails_helper"

RSpec.describe Chroma do
  describe "#normalize" do
    context "when 3 digit valid hex" do
      it "returns a valid 6 digit hex value" do
        expect(described_class.new("#242").normalize).to eq("#242242")
        expect(described_class.new("#2EE").normalize).to eq("#2ee2ee")
      end
    end

    context "when 6 digit valid hex" do
      it "returns the same downcased value" do
        expect(described_class.new("#24292E").normalize).to eq("#24292e")
      end
    end

    context "when invalid hex" do
      it "raises an error" do
        expect do
          described_class.new("#lksag")
        end.to raise_error(ArgumentError)
      end
    end
  end
end
