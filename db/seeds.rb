# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Talk.delete_all
Idea.delete_all
Member.delete_all
ActionsTaken.delete_all
Action.delete_all
Reaction.delete_all

if Rails.env.test? or Rails.env.development?

  talks = Talk.create!(
      [
        { 
          title: 'Amy Cuddy: Your body language shapes who you are', 
          description: 'Body language affects how others see us, but it may also change how we see ourselves. Social psychologist Amy Cuddy shows how "power posing" -- standing in a posture of confidence, even when we don\'t feel confident -- can affect testosterone and cortisol levels in the brain, and might even have an impact on our chances for success.',
          ideas: [
            { body: 'Body language affects how others see us, but it may also change how we see ourselves.',
              actions: [
                { description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse varius auctor ligula, et dapibus erat ullamcorper ut. Donec egestas placerat erat a lacinia. Nunc volutpat nisi et nulla sollicitudin venenatis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.' },
                { description: 'Ut mattis orci id nisl eleifend ultricies. Nulla laoreet arcu eu urna sodales eu facilisis libero sagittis. Fusce id odio at nisl convallis aliquet. Quisque id purus velit, id volutpat felis. Pellentesque id mi lacus.' }
              ].map() { | action_attrs | Action.new(action_attrs) },
              reactions: [
                { text: 'This is a good idea' },
                { text: 'I think I will try one of these actions' }
              ].map() { | reaction_attrs | Reaction.new(reaction_attrs) }
            },
            { body: '"power posing" can affect testosterone and cortisol levels in the brain, may impact on our chances for success.',
              actions: [
                { description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse varius auctor ligula, et dapibus erat ullamcorper ut. Donec egestas placerat erat a lacinia. Nunc volutpat nisi et nulla sollicitudin venenatis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.' },
                { description: 'Ut mattis orci id nisl eleifend ultricies. Nulla laoreet arcu eu urna sodales eu facilisis libero sagittis. Fusce id odio at nisl convallis aliquet. Quisque id purus velit, id volutpat felis. Pellentesque id mi lacus.' }
              ].map() { | action_attrs | Action.new(action_attrs) },
              reactions: [
                { text: 'This is a good idea' },
                { text: 'I think I will try one of these actions' }
              ].map() { | reaction_attrs | Reaction.new(reaction_attrs) }
            }
          ].map() { | idea_attrs | Idea.new(idea_attrs) }
        },
        { 
          title: 'Steve Jobs: How to live before you die', 
          description: 'At his Stanford University commencement speech, Steve Jobs, CEO and co-founder of Apple and Pixar, urges us to pursue our dreams and see the opportunities in life\'s setbacks -- including death itself.',
        },
      ]
    )

  member1 = Member.create! persistence_token: '1234'
  member2 = Member.create! persistence_token: '5678'
  member3 = Member.create! persistence_token: '9012'

  ActionsTaken.create! action: Action.first, member: member1
  ActionsTaken.create! action: Action.first, member: member2
  ActionsTaken.create! action: Action.first, member: member3

end