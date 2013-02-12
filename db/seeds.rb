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

  event = Event.create!({ 
    name: 'TEDActive', 
    description: 'TEDActive is a curated community of 700 curious and energetic leaders who share an immersive week of TEDTalks and surprising experiences designed to inspire conversation, exchange and immediate action around ideas worth spreading.',
    logo_image_url: 'http://conferences.ted.com/TEDActive2013/images/logo.png?20091208',
    hero_image_url: 'http://conferences.ted.com/TED2013/images/auditions/talentsearch_f.jpg',
    talks: [
        { 
          title: 'Amy Cuddy: Your body language shapes who you are', 
          description: 'Body language affects how others see us, but it may also change how we see ourselves. Social psychologist Amy Cuddy shows how "power posing" -- standing in a posture of confidence, even when we don\'t feel confident -- can affect testosterone and cortisol levels in the brain, and might even have an impact on our chances for success.',
          ideas: [
            { body: 'Body language affects how others see us, but it may also change how we see ourselves.',
              actions: [
                { description: 'Examine your own body language in different social situations.' },
              ].map() { | action_attrs | Action.new(action_attrs) },
              reactions: [
                { text: 'This is a good idea' },
                { text: 'I think I will try one of these actions' }
              ].map() { | reaction_attrs | Reaction.new(reaction_attrs) }
            },
            { body: '"power posing" can affect testosterone and cortisol levels in the brain, may impact on our chances for success.',
              actions: [
                { description: 'Power-pose for two minutes before an important meeting.' },
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
    ].map { | talk_attrs | Talk.new(talk_attrs) }
  })

  member1 = Member.create! persistence_token: '1234'
  member2 = Member.create! persistence_token: '5678'
  member3 = Member.create! persistence_token: '9012'

  ActionsTaken.create! action: Action.first, member: member1
  ActionsTaken.create! action: Action.first, member: member2
  ActionsTaken.create! action: Action.first, member: member3

  Reaction.create!({ 
    idea: Idea.first, 
    member: member1, 
    :text => 'i think you have come up with something big here',
  })

  Reaction.create!({
    idea: Idea.first, 
    member: member1, 
    text: 'what else can I say?',
  })

  Reaction.create!({
    idea: Idea.first, 
    member: member1, 
    text: 'There is some useful information here',
  })

  anoter_event = Event.create! :name => 'another', :talks => [ Talk.new ]

end