namespace :reminder do
  desc "Send reminder emails to users"
  task send_emails: :environment do
    User.where(receive_reminders: true).find_each do |user|
      ReminderMailer.reminder_email(user).deliver_now
    end
  end
end
