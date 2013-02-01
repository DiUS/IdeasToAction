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
          # ideas: Idea.new([
          #   { body: 'Body language affects how others see us, but it may also change how we see ourselves.'},
          #   { body: '"power posing" can affect testosterone and cortisol levels in the brain, may impact on our chances for success.'}
          # ])
        }
      ]
    )

end