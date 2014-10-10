class Talk < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  index_name { "#{Rails.env}-#{table_name}" }
      
  tire.instance_eval do
    # This is a work-around to allow setting the mapping without the indexes actually being created by Tire

    @mapping ||= {}

    indexes :id,              :index    => :not_analyzed
    indexes :event_id,        :index    => :not_analyzed
    indexes :created_at,      :type => 'date', :include_in_all => false
    indexes :updated_at,      :type => 'date', :include_in_all => false
    indexes :title,           :boost => 100
    indexes :description
    indexes :ted_talk_url,    :index    => :not_analyzed
    indexes :hero_image_url,  :index    => :not_analyzed
  end  
      
  attr_accessible :description, :title, :ideas, :hero_image_url, :ted_talk_url, :featured, :event_id, :viewable, :event

  has_many :ideas, through: :talk_to_idea_associations
  has_many :idea_actions, through: :ideas
  has_many :talk_to_idea_associations

  belongs_to :event

  validates :event, :title, :description, :presence => true

  delegate :name, :to => :event, :prefix => true

  after_destroy :destroy_ideas_without_talks

  def self.random(number = 1)
    Talk.offset(rand(Talk.count - number + 1)).first(number)
  end

  def self.featured
    where(featured: true)
  end

  def self.recent
    order("created_at desc").limit(10)
  end

  def self.popular
    order("idea_actions_count desc").limit(10)
  end

  def self.excluding_talks(talk_ids)
    where("talks.id not in (?)", talk_ids)
  end

  def self.viewable
    where(viewable: true)
  end

  def self.total
    viewable.count
  end

  def destroy_ideas_without_talks
    self.ideas.each do |idea|
      idea.destroy if idea.talks.size.zero?
    end
  end
end
