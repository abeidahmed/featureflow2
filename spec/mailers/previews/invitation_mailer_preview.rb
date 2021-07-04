class InvitationMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/invitation_mailer/account_invitation
  def account_invitation
    InvitationMailer.with(collaborator: Collaborator.last).account_invitation
  end
end
