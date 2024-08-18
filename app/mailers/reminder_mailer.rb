class ReminderMailer < Devise::Mailer
  default from: 'speakup.2405@gmail.com'

  def reminder_email(user)
    @user = user
    mail(to: @user.email, subject: '【SpeakUp】学習リマインダー')
  end
end
