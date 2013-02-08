class Member < ActiveRecord::Base
  attr_accessible :persistence_token

  acts_as_authentic

  has_many :actions_taken

  has_many :reactions

  has_many :actions, :through => :actions_taken
end