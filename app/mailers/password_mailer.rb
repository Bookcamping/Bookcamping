# encoding: utf-8
class PasswordMailer < ActionMailer::Base
  default from: "hola@bookcamping.cc"
  layout 'mail'
  default_url_options[:host] = Site.host

  def recovery_password(user_id)
    @user = User.find user_id
    if @user.email.present?
      @host = Site.host
      mail to: @user.email, subject: 'Bookcamping: recuperar contraseña'
    end
  end
end

