class FriendsMailer < ApplicationMailer
  def send_invitation(user)
    @user = user
    @url  = "#{Rails.application.secrets.ui_url}confirm-account/#{user.confirmation_token}"
    mail(to: @user.email, subject: 'Confirmación Participante Colecta Fundación Cecilia Rivadeneira')
  end

  def send_leader_email(user)
    @user = user
    @url  = "#{Rails.application.secrets.ui_url}confirm-account/#{user.confirmation_token}"
    mail(to: @user.email, subject: 'Confirmación Participante Colecta Fundación Cecilia Rivadeneira')
  end
end
