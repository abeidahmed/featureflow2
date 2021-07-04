require "rails_helper"

RSpec.describe InvitationMailer, type: :mailer do
  describe "account_invitation" do
    let(:account) { create(:account) }
    let(:collaborator) { create(:collaborator, :pending, account: account) }
    let(:mail) { described_class.with(collaborator: collaborator).account_invitation }

    it "renders the headers" do
      expect(mail.subject).to eq("Invitation to #{collaborator.account.name}")
      expect(mail.to).to eq([collaborator.email])
      expect(mail.from).to eq(["support@featureflow.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(invitation_url(collaborator.token, subdomain: "app"))
    end
  end
end
