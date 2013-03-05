class Talk < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  index_name { "#{Rails.env}-#{table_name}" }
      
  attr_accessible :description, :title, :ideas, :hero_image_url, :ted_talk_url

  has_many :ideas, through: :talk_to_idea_associations
  has_many :talk_to_idea_associations

  belongs_to :event
end
