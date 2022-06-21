class NotifyMailer < ApplicationMailer
  def user_deadlines(user, tasks)
    @tasks = tasks
    attachments.inline['notify_mailer.rb'] = File.read('/home/maks/gb_app/simple-todo/app/mailers/notify_mailer.rb')
    mail(
      to: email_address_with_name(user.email, user.name), 
      subject: I18n.t('emails.subjects.user_deadlines')
    )
  end
end
