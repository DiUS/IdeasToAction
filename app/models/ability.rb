class Ability
  include CanCan::Ability

  def initialize(member)
    member ||= Member.new

    if member.global_admin?
      can :manage, :all
    elsif member.content_admin?
      can :read, :all
      can :manage, IdeaAction
      can :manage, Event
      can :manage, Idea
      can :manage, Talk
      can :manage, Member do |the_member|
        the_member == member
      end
      can :manage, Interaction
    else
      can :read, :all
      can :ideas, Event

      can :random, IdeaAction
      can :recent, IdeaAction
      can :doneIt, IdeaAction
      can :react, IdeaAction
      can :create, IdeaAction

      can :random, Idea
      can :create, Idea
      can :show_idea_url, Idea
      can :create, Interaction
      can :update, Interaction do |interaction|
        member == interaction.member
      end

      can :manage, Member do |the_member|
        the_member == member
      end
    end
  end
end
