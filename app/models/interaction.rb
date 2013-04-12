class Interaction < ActiveRecord::Base
  attr_accessible :idea_action, :idea_action_id, :member, :member_id, :reaction_text

  belongs_to :idea_action
  belongs_to :member

  delegate :description, :to => :idea_action, :prefix => true
  delegate :username, :to => :member, :prefix => true

  validates :member_id, :idea_action_id, :presence => true

  after_save :manage_counters
  after_destroy :decrement_counters

  def self.find_by_member member
    find(:all, :conditions => ['member_id = ?', member.id])
  end

  private

  def manage_counters
    if reaction_text_changed? && reaction_text_was.nil? && reaction_text.present?
      self.idea_action.idea.talks.each do |talk|
        Event.increment_counter(:reactions_count, talk.event.id)
        Talk.increment_counter(:reactions_count, talk.id)
      end
      Idea.increment_counter(:reactions_count, self.idea_action.idea.id)
      IdeaAction.increment_counter(:reactions_count, self.idea_action.id)
    end

    if reaction_text_changed? && reaction_text_was.present? && !reaction_text.present?
      self.idea_action.idea.talks.each do |talk|
        Event.decrement_counter(:reactions_count, talk.event.id)
        Talk.decrement_counter(:reactions_count, talk.id)
      end
      Idea.decrement_counter(:reactions_count, self.idea_action.idea.id)
      IdeaAction.decrement_counter(:reactions_count, self.idea_action.id)

    end
  end

  def decrement_counters
    self.idea_action.idea.talks.each do |talk|
      Event.decrement_counter(:reactions_count, talk.event.id)
      Talk.decrement_counter(:reactions_count, talk.id)
    end
    Idea.decrement_counter(:reactions_count, self.idea_action.idea.id)
    IdeaAction.decrement_counter(:reactions_count, self.idea_action.id)
  end
end
