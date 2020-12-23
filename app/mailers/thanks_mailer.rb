class ThanksMailer < ApplicationMailer
  default from: 'no-replay@gmail.com'

  def complete_mail(user)
    @user = user
    mail(subject: "COMPLETE join your address", to: user.email)
  end
end
