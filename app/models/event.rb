class Event < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks
      
  index_name { "#{Rails.env}-#{table_name}" }
      
  mapping do
    indexes :id,              :index    => :not_analyzed
    indexes :created_at,      :type => 'date', :include_in_all => false
    indexes :updated_at,      :type => 'date', :include_in_all => false
    indexes :name,            :boost => 100
    indexes :description
    indexes :logo_image_url,  :index    => :not_analyzed
    indexes :hero_image_url,  :index    => :not_analyzed
  end  
      
  attr_accessible :name, :talks, :description, :logo_image_url, :hero_image_url

  has_many :talks
  has_many :ideas, :through => :talks

  validates :name, :description, :hero_image_url, :presence => true
end
