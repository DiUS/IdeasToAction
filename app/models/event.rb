class Event < ActiveRecord::Base
  attr_accessible :name, :talks, :description, :logo_image_url, :hero_image_url

  has_many :talks
  has_many :ideas, :through => :talks
end
