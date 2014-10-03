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
      
  attr_accessible :description, :featured, :idea_id, :idea, :member, :completion_date, :target_date

  belongs_to :idea, :inverse_of => :idea_actions, :counter_cache => true
	belongs_to :member

	scope :incomplete_first, -> { order('completion_date IS NOT NULL, completion_date DESC') }
	scope :member_first, ->(member) { order("member_id <> #{member.id}") }
	scope :incomplete, -> { where(completion_date: nil) }
	scope :completed, -> { where('completion_date IS NOT NULL') }

  validates :idea, :description, :target_date, :presence => true

  delegate :description, :to => :idea, :prefix => true

  after_create :increment_counter
  after_destroy :decrement_counter

	def complete?
		completion_date.present?
	end
  alias_method :completed?, :complete?

  def incomplete?
    !complete?
  end

	def completable?(current_member)
		member == current_member && incomplete?
	end

	def mine?(current_member)
		member == current_member
	end

  def due_soon?
    target_date <= 1.week.from_now
  end

  def remindable?
    incomplete? && due_soon? && !reminded?
  end

  def self.random(number = 1)
    IdeaAction.offset(rand(IdeaAction.count - number+1)).first(number)
  end

  def self.featured
    where(:featured => true)
  end

  def self.recent
    order("created_at desc").limit(10)
  end

  def self.excluding_idea_actions(idea_action_ids)
    where("id not in (?)", idea_action_ids)
  end

  def self.descriptions
    all.map{|idea_action| ["(#{idea_action.id}) #{idea_action.description.truncate(35)}", idea_action.id]}
	end

  def self.remindable(member = nil)
    query = [
      "completion_date is null",
      "target_date <= '#{1.week.from_now.to_date}'",
      "reminded = false"
    ]
    query += ["member_id = #{member.id}"] if member
    where(query.join(' and '))
  end

  def self.reminded(idea_actions)
    idea_actions.each{|idea_action| idea_action.update_attribute(reminded: true)}
  end

  private

  def increment_counter
    self.idea.talks.each do |talk|
      Event.increment_counter(:idea_actions_count, talk.event.id)
      Talk.increment_counter(:idea_actions_count, talk.id)
    end
  end

  def decrement_counter
    self.idea.talks.each do |talk|
      Event.decrement_counter(:idea_actions_count, talk.event.id)
      Talk.decrement_counter(:idea_actions_count, talk.id)
    end
  end
end
