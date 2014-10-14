class Mailer < ActionMailer::Base

  default from: "no-reply+#{Rails.env}@tedxultimo.com"

  def remind(member)
    if member.remindable?
      @actions = member.remindable_actions
      mail_with_error_logging(to: member.email, subject: "TEDxUltimo Reminder", callback: [:bulk_set_reminded_idea_actions, @actions])
    end
  end

  def reminders(*members)
    members = Member.with_remindable_actions if members.flatten!.blank?
    members.each{|member| remind(member)}
  end

  def welcome(member)
    mail_with_error_logging(to: member.email, subject: "TEDxUltimo Welcome")
  end

  private

  def mail_with_error_logging(*args)
    params = args.extract_options!
    mail_object = mail(to: params[:to], subject: params[:subject]).deliver
    self.send(params[:callback].first, params[:callback].second) if params[:callback]
    mail_object
  rescue *SMTP_ERRORS => e
    Rails.logger.error("Attempting to send an email to #{to} with subject #{subject} produced an error.")
    Rails.logger.error(e)
  end

  def bulk_set_reminded_idea_actions(actions)
    IdeaAction.bulk_set_reminded(actions)
  end

end
