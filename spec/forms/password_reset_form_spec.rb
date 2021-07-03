require "rails_helper"

RSpec.describe PasswordResetForm do
  let(:user) { create(:user) }

  context "when request is valid" do
    it "updates the password" do
      sgid = user.signed_id(expires_in: 2.hours, purpose: :password_reset)
      described_class.new(password: "mamakane", password_confirmation: "mamakane", id: sgid).save

      user.reload
      expect(user.authenticate("mamakane")).to eq(user)
    end
  end

  context "when password and password_confirmation do not match" do
    it "does not update the password" do
      sgid = user.signed_id(expires_in: 2.hours, purpose: :password_reset)
      resetable_user = described_class.new(password: "mamakane", password_confirmation: "MAMAKANE", id: sgid)
      resetable_user.save

      user.reload
      expect(user.authenticate("mamakane")).to be_falsy
      expect(resetable_user.errors[:password_confirmation]).to be_present
    end
  end

  context "when password is too short" do
    it "does not update the password" do
      sgid = user.signed_id(expires_in: 2.hours, purpose: :password_reset)
      resetable_user = described_class.new(password: "a", password_confirmation: "a", id: sgid)
      resetable_user.save

      user.reload
      expect(user.authenticate("a")).to be_falsy
      expect(resetable_user.errors[:password]).to be_present
    end
  end

  context "when password is blank" do
    it "returns an error" do
      sgid = user.signed_id(expires_in: 2.hours, purpose: :password_reset)
      resetable_user = described_class.new(password: "", password_confirmation: "", id: sgid)
      resetable_user.save

      expect(resetable_user.errors[:password]).to be_present
    end
  end

  context "when signed_id is invalid" do
    it "raises an error" do
      sgid = user.signed_id(expires_in: 2.hours, purpose: :invalid)
      resetable_user = described_class.new(password: "mamakane", password_confirmation: "mamakane", id: sgid)

      expect do
        resetable_user.save
      end.to raise_error(ActiveSupport::MessageVerifier::InvalidSignature)
    end
  end
end
