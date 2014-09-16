class Member < ActiveRecord::Base
  ROLE_REGULAR = "REGULAR"
  ROLE_CONTENT_ADMIN = "CONTENT_ADMIN"
  ROLE_GLOBAL_ADMIN = "GLOBAL_ADMIN"

  attr_accessible :persistence_token, :username, :password, :role

  acts_as_authentic do |c|
    c.session_class = MemberSession
    c.validate_password_field = false
    c.validate_login_field = false
  end

  has_many :interactions

  has_many :idea_actions, :through => :interactions #needed?

  def self.usernames
    all.map{|member| ["(#{member.id}) #{member.username ? member.username : 'Anonymous'}", member.id]}
  end

  def content_admin?
    self.role == ROLE_CONTENT_ADMIN
  end

  def global_admin?
    self.role ==  ROLE_GLOBAL_ADMIN
  end
end