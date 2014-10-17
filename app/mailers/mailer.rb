class Mailer < ActionMailer::Base

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
    options = args.extract_options!
    to, subject = options[:to], options[:subject]
    callback_method_name = options[:callback] && options[:callback].first
    callback_argument = options[:callback] && options[:callback].second
    mail_object = mail(to: to, subject: subject).deliver
    self.send(callback_method_name, callback_argument) if options[:callback]
    mail_object
  rescue *SMTP_ERRORS => e
    Rails.logger.error("Attempting to send an email to #{to} with subject #{subject} produced an error.")
    Rails.logger.error(e)
  end

  def bulk_set_reminded_idea_actions(actions)
    IdeaAction.bulk_set_reminded(actions)
  end

end
