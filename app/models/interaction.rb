class Interaction < ActiveRecord::Base
  attr_accessible :idea_action, :idea_action_id, :member, :member_id, :reaction_text

  belongs_to :idea_action
  belongs_to :member

  delegate :description, :to => :idea_action, :prefix => true
  delegate :username, :to => :member, :prefix => true

  def self.find_by_member member
    find(:all, :conditions => ['member_id = ?', member.id])
  end

  after_save :manage_counters
  after_destroy :decrement_counters

  private

  def manage_counters
    if reaction_text_changed? && reaction_text_was.nil? && reaction_text.present?
      self.idea_action.idea.talks.each do |talk|
        Event.increment_counter(:reactions_count, talk.event.id)
        Talk.increment_counter(:reactions_count, talk.id)
        Idea.increment_counter(:reactions_count, talk.id)
      end
    end

    if reaction_text_changed? && reaction_text_was.present? && !reaction_text.present?
      self.idea_action.idea.talks.each do |talk|
        Event.decrement_counter(:reactions_count, talk.event.id)
        Talk.decrement_counter(:reactions_count, talk.id)
        Idea.decrement_counter(:reactions_count, talk.id)
      end
    end
  end

  def decrement_counters
    self.idea_action.idea.talks.each do |talk|
      Event.decrement_counter(:reactions_count, talk.event.id)
      Talk.decrement_counter(:reactions_count, talk.id)
      Idea.decrement_counter(:reactions_count, talk.id)
    end
  end
end
