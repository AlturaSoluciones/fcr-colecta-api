class FriendsMailer < ApplicationMailer
  def send_invitation(user)
    @user = user
    @url  = 'http://colecta.acolita.org'
    puts @user.email
    puts Rails.env
    mail(to: @user.email, subject: 'Confirmación Participante Colecta Fundación Cecilia Rivadeneira')
  end
end
