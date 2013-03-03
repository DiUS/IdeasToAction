class Member < ActiveRecord::Base
  attr_accessible :persistence_token, :username, :password

  acts_as_authentic do |c|
    c.validate_password_field = false
    c.validate_login_field = false
  end

  has_many :actions_taken

  has_many :reactions

  has_many :actions, :through => :actions_taken
end