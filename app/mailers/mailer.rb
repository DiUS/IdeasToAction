class Mailer < ActionMailer::Base

  def remind(*members)
    members = Member.remindable_actions if members.flatten!.blank?
    members.each do |member|
      if member.remindable?
        begin
          @actions = member.remindable_actions
          to = member.email
          subject = "TEDx Reminder"
          mail(to: to, subject: subject)
          IdeaAction.reminded(@actions)
        rescue *SMTP_ERRORS => e
          Rails.logger.error("Attempting to send an email to #{to} with subject #{subject} produced an error.")
          Rails.logger.error(e)
        end
      end
    end
  end

end
