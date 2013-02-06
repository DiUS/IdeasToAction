class Member < ActiveRecord::Base
  attr_accessible :persistence_token

  acts_as_authentic
end