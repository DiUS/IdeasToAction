class Ability
  include CanCan::Ability

  def initialize(member)
    member ||= Member.new

    if member.global_admin?
      can :manage, :all
    elsif member.content_admin?
      can :read, :all
      can :manage, Action
      can :manage, Event
      can :manage, Idea
      can :manage, Talk
      can :manage, Member do |the_member|
        the_member == member
      end
    else
      can :read, :all
      can :ideas, Event

      can :random, Action
      can :recent, Action
      can :doneIt, Action

      can :random, Idea
      can :react, Idea
      can :create, Idea
      can :show_idea_url, Idea

      can :manage, Member do |the_member|
        the_member == member
      end
    end
  end
end
