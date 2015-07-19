class SettingsMailer < ApplicationMailer
  default from: "derek.covey@gmail.com"

  def update_email(user)
    attachments.inline['logo.png'] = File.read("#{Rails.root}/public/assets/logo.png")
    @user = user
    mail(to: user.email, subject: "Shrtnr Settings Updated")
  end

end
