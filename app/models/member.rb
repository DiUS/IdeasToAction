class Member < ActiveRecord::Base
  ROLE_REGULAR = "REGULAR"
  ROLE_CONTENT_ADMIN = "CONTENT_ADMIN"
  ROLE_GLOBAL_ADMIN = "GLOBAL_ADMIN"

  attr_accessible :persistence_token, :password, :role, :email

  acts_as_authentic do |c|
    c.session_class = MemberSession
    c.validate_password_field = false
    c.validate_login_field = false
    c.validate_email_field = true
		c.merge_validates_format_of_email_field_options message: 'not a valid email'
  end

  has_many :idea_actions, dependent: :destroy

  def self.emails
    all.map{|member| ["(#{member.id}) #{member.email}", member.id]}
  end

  def self.with_remindable_actions
    all.select{|member| !member.remindable_actions.empty?}
  end

  def remindable_actions
    IdeaAction.remindable(self)
  end

  # boolean methods

  def content_admin?
    self.role == ROLE_CONTENT_ADMIN
  end

  def global_admin?
    self.role == ROLE_GLOBAL_ADMIN
  end

  def remindable?
    idea_actions.any?{|idea_action| idea_action.remindable?}
  end

end
