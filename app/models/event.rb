class Event < ActiveRecord::Base
  attr_accessible :name, :talks

  has_many :talks
  has_many :ideas, :through => :talks
end
