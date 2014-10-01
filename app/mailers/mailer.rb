class Mailer < ActionMailer::Base

  def remind(*members)
    members = Member.remindable_actions if members.flatten!.blank?
    members.each do |member|
      if member.remindable?
        @actions = member.remindable_actions
        mail(to: member.email, subject: "TEDx Reminder")
      end
    end
  end

end
