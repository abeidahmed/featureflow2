require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "password_reset" do
    let(:user) { create(:user) }
    let(:sgid) { user.signed_id(purpose: :password_reset, expires_in: 2.hours) }
    let(:mail) { described_class.with(user: user, sgid: sgid).password_reset }

    it "renders the headers" do
      expect(mail.subject).to eq("Password reset instruction")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["support@featureflow.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(edit_password_reset_url(sgid, subdomain: "app"))
    end
  end
end
