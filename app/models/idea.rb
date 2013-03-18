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
  validates_presence_of :member

  has_many :talk_to_idea_associations
  has_many :talks, through: :talk_to_idea_associations
  validates_length_of :talks, minimum: 1

  has_many :idea_actions
  has_many :reactions

  has_and_belongs_to_many :tags

  attr_accessible :tags, :talks, :description, :idea_actions, :reactions, :featured

  def self.featured_only
    where(:featured => true)
  end

  def self.random
    Idea.first(:offset => rand(Idea.count))
  end

  def as_json options = nil
    super.merge(members_actioned_count: members_actioned.size, tags: tags)
  end

  def bitly_url
    bitly = Bitly.new(CONFIG[:bitly][:username], CONFIG[:bitly][:api_key])
    bitly_short_url = bitly.shorten("#{CONFIG[Rails.env.to_sym][:host]}/ideas/#{self.id}").short_url
    URI::escape(bitly_short_url)
  end

  def members_actioned
    Idea.find_by_sql("select distinct at.member_id from " + 
                      "ideas i, actions_taken at, idea_actions a where " +
                      "a.idea_id = i.id and at.idea_action_id = a.id and i.id = #{self.id}")
  end
end
