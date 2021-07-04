class InvitationMailer < ApplicationMailer
  def account_invitation
    @collaborator = params[:collaborator]

    mail \
      to: email_address_with_name(@collaborator.email, @collaborator.name),
      subject: "Invitation to #{@collaborator.account.name}"
  end
end
