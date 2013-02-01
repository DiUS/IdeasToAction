# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env.test? or Rails.env.development?

  talks = Talk.create!(
      [
        { 
          title: 'Amy Cuddy: Your body language shapes who you are', 
          description: 'Body language affects how others see us, but it may also change how we see ourselves. Social psychologist Amy Cuddy shows how "power posing" -- standing in a posture of confidence, even when we don\'t feel confident -- can affect testosterone and cortisol levels in the brain, and might even have an impact on our chances for success.',
          ideas: [
            { body: 'Body language affects how others see us, but it may also change how we see ourselves.'},
            { body: '"power posing" can affect testosterone and cortisol levels in the brain, may impact on our chances for success.'}
          ].map() { | idea_attrs | Idea.new(idea_attrs) }
        },
        { 
          title: 'Steve Jobs: How to live before you die', 
          description: 'At his Stanford University commencement speech, Steve Jobs, CEO and co-founder of Apple and Pixar, urges us to pursue our dreams and see the opportunities in life\'s setbacks -- including death itself.',
        },
      ]
    )

end