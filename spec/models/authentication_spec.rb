require "rails_helper"

RSpec.describe Authentication do
  describe "#user" do
    it "returns the user if present" do
      user = create(:user)
      auth = described_class.new(email: user.email, password: user.password)

      expect(auth.user).to eq(user)
    end

    it "returns the user for case insensitive email" do
      user = create(:user)
      auth = described_class.new(email: user.email.upcase, password: user.password)

      expect(auth.user).to eq(user)
    end

    it "returns nil if user is not found" do
      auth = described_class.new(email: "invalid@email.com", password: "password")

      expect(auth.user).to be_nil
    end

    it "returns nil if user's credentials do not match" do
      user = create(:user)
      auth = described_class.new(email: user.email, password: "invalidpassword")

      expect(auth.user).to be_nil
    end
  end

  describe "#authenticated?" do
    it "returns true if user is found" do
      user = create(:user)
      auth = described_class.new(email: user.email, password: user.password)

      expect(auth).to be_authenticated
    end

    it "returns false if user is not found" do
      auth = described_class.new(email: "invalid@email.com", password: "password")

      expect(auth).not_to be_authenticated
    end
  end
end
