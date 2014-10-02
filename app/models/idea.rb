class Idea < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  index_name { "#{Rails.env}-#{table_name}" }

  tire.instance_eval do
    # This is a work-around to allow setting the mapping without the indexes actually being created by Tire
    @mapping ||= {}

    indexes :id,           :index    => :not_analyzed
    indexes :member_id,    :index    => :not_analyzed
    indexes :created_at,   :type => 'date', :include_in_all => false
    indexes :updated_at,   :type => 'date', :include_in_all => false
    indexes :description,  :boost => 100
  end  
      
  belongs_to :member

  has_many :talk_to_idea_associations
  has_many :talks, through: :talk_to_idea_associations
  has_many :idea_actions, :inverse_of => :idea, :dependent => :destroy
  has_and_belongs_to_many :tags

  validates_length_of :talks, minimum: 1
  validates :member, :description, :presence => true

  accepts_nested_attributes_for :idea_actions

  attr_accessible :tags, :talks, :description, :idea_actions, :featured, :member_id, :talk_ids, :idea_actions_attributes

  delegate :username, :to => :member, :prefix => true

  after_create :increment_counters
  after_destroy :decrement_counters

  def self.random(number = 1)
    Idea.offset(rand(Idea.count - number+1)).first(number)
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

  def self.excluding_ideas(idea_ids)
    where("id not in (?)", idea_ids)
  end

  def self.descriptions
    all.map{|idea| ["(#{idea.id}) #{idea.description.truncate(35)}", idea.id]}
  end

  def as_json options = nil
    super.merge tags: tags
  end

  def bitly_url
    bitly = Bitly.new(CONFIG[:bitly][:username], CONFIG[:bitly][:api_key])
    bitly_short_url = bitly.shorten("#{CONFIG[Rails.env.to_sym][:host]}/ideas/#{self.id}").short_url
    URI::escape(bitly_short_url)
  end

  private

  def increment_counters
    self.talks.each do |talk|
      Event.increment_counter(:ideas_count, talk.event.id)
      Talk.increment_counter(:ideas_count, talk.id)
    end
  end

  def decrement_counters
    self.talks.each do |talk|
      Event.decrement_counter(:ideas_count, talk.event.id)
      Talk.decrement_counter(:ideas_count, talk.id)
    end
  end
end
