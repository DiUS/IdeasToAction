class Idea < ActiveRecord::Base
  attr_accessible :body, :actions

  has_many :actions
end
