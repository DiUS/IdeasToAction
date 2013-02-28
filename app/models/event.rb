class Event < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks
      
  index_name { "#{Rails.env}-#{table_name}" }
      
  attr_accessible :name, :talks, :description, :logo_image_url, :hero_image_url

  has_many :talks
  has_many :ideas, :through => :talks
end
