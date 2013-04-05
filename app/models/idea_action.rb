class IdeaAction < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  index_name { "#{Rails.env}-#{table_name}" }
  
  tire.instance_eval do
    # This is a work-around to allow setting the mapping without the indexes actually being created by Tire

    @mapping ||= {}

    indexes :id,              :index    => :not_analyzed
    indexes :idea_id,         :index    => :not_analyzed
    indexes :created_at,      :type => 'date', :include_in_all => false
    indexes :updated_at,      :type => 'date', :include_in_all => false
    indexes :description,     :boost => 100
  end  
      
  attr_accessible :description, :featured, :idea_id

  belongs_to :idea

  has_many :interactions do
    def from_member member
      find(:first, :conditions => ['member_id = ?', member.id])
    end
  end

  delegate :description, :to => :idea, :prefix => true

  after_create :increment_counter_on_events
  after_destroy :decrement_counter_on_events

  def self.featured_only
    where(:featured => true)
  end

  def self.random
    IdeaAction.first(:offset => rand(IdeaAction.count))
  end

  def as_json options = nil
    super.merge(members_actioned_count: members_actioned.size)
  end

  def members_actioned #TODO: do we need this ? just go through interaction model
    Idea.find_by_sql("select distinct ins.member_id from " + 
                      "idea_actions a, interactions ins where " +
                      "ins.idea_action_id = a.id and a.id = #{self.id}")
  end

  private

  def increment_counter_on_events
    self.idea.talks.each do |talk|
      Event.increment_counter(:idea_actions_count, talk.event.id)
    end
  end

  def decrement_counter_on_events
    self.idea.talks.each do |talk|
      Event.decrement_counter(:idea_actions_count, talk.event.id)
    end
  end
end
