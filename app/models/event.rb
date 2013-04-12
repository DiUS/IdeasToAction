class Event < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks
      
  index_name { "#{Rails.env}-#{table_name}" }
      
  tire.instance_eval do
    # This is a work-around to allow setting the mapping without the indexes actually being created by Tire

    @mapping ||= {}

    indexes :id,              :index    => :not_analyzed
    indexes :created_at,      :type => 'date', :include_in_all => false
    indexes :updated_at,      :type => 'date', :include_in_all => false
    indexes :name,            :boost => 100
    indexes :description
    indexes :logo_image_url,  :index    => :not_analyzed
    indexes :hero_image_url,  :index    => :not_analyzed
  end  
      
  attr_accessible :name, :talks, :description, :logo_image_url, :hero_image_url, :featured

  has_many :talks, :dependent => :destroy
  has_many :ideas, :through => :talks
  has_many :idea_actions, :through => :talks

  validates :name, :description, :hero_image_url, :presence => true

  def self.random(number = 1)
    Event.offset(rand(Event.count - number)).first(number)
  end

  def self.featured
    where(:featured => true)
  end

  def self.recent
    order("created_at desc").limit(10)
  end

  def self.popular
    order("idea_actions_count desc").limit(10)
  end

  def self.excluding_events(events)
    where("id not in (?)", events.collect(&:id))
  end
end
