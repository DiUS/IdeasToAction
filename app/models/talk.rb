class Talk < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  index_name { "#{Rails.env}-#{table_name}" }
      
  mapping do
    indexes :id,              :index    => :not_analyzed
    indexes :event_id,        :index    => :not_analyzed
    indexes :created_at,      :type => 'date', :include_in_all => false
    indexes :updated_at,      :type => 'date', :include_in_all => false
    indexes :title,           :boost => 100
    indexes :description
    indexes :ted_talk_url,    :index    => :not_analyzed
    indexes :hero_image_url,  :index    => :not_analyzed
  end  
      
  attr_accessible :description, :title, :ideas, :hero_image_url, :ted_talk_url

  has_many :ideas, through: :talk_to_idea_associations
  has_many :talk_to_idea_associations

  belongs_to :event
end
