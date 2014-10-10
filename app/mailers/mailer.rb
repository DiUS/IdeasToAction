class Mailer < ActionMailer::Base

  default from: "no-reply+#{Rails.env}@tedxultimo.com"

  def remind(member)
    if member.remindable?
      begin
        @actions = member.remindable_actions
        to = member.email
        subject = "TEDx Reminder"
        mailer = mail(to: to, subject: subject)
        IdeaAction.bulk_set_reminded(@actions)
        mailer
      rescue *SMTP_ERRORS => e
        Rails.logger.error("Attempting to send an email to #{to} with subject #{subject} produced an error.")
        Rails.logger.error(e)
      end
    end
  end

  def reminders(*members)
    members = Member.with_remindable_actions if members.flatten!.blank?
    members.each{|member| remind(member)}
  end

end
