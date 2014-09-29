# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if %w(test development qa).include? Rails.env
  puts "Seeding in #{Idea.connection_config[:database]}..."

  Tag.delete_all
  Event.delete_all
  Talk.delete_all
  Idea.delete_all
  Member.delete_all
  IdeaAction.delete_all

  # Setup
  member1 = Member.create! persistence_token: '1234'
  member2 = Member.create! persistence_token: '5678'
  member3 = Member.create! persistence_token: '9012'
  member4 = Member.create! persistence_token: '6732'
  member5 = Member.create! persistence_token: '7654'
  member6 = Member.create! persistence_token: '4353'
  member7 = Member.create! persistence_token: '3456'

  Member.create! username: "content_admin", password: "TEDc0nt3nt", :role => Member::ROLE_CONTENT_ADMIN
  Member.create! username: "global_admin", password: "TED4dm1n", :role => Member::ROLE_GLOBAL_ADMIN

  tags = Pathname("db/tag_data.csv").readlines.map { | tag_name | Tag.create!(name: tag_name.strip)}

  #
  # TED Global 2012
  #
  ted_global_2012 = Event.create!(
    name: 'TED Global 2012',
    description: 'As the world becomes interconnected, the ways we relate and learn about one another (and the rules about what we share) are changing. That was the inspiration for TEDGlobal 2012: Radical Openness, held in Edinburgh.',
    hero_image_url: 'http://farm8.staticflickr.com/7253/7450449710_23216321ae_z.jpg'
  )

  paolo_cardini_talk = Talk.create!(
    title: 'Paolo Cardini: Forget Multitasking, try monotasking - a 3-minute talk', 
    description: 'An invitation to "downgrade" our hyper-multitasking phones with clever Mono Task covers that remind us of their essential functions, and more important, to create our own "mono tasking" reality, which is better aligned with how most human minds work.',
    hero_image_url: 'http://images.ted.com/images/ted/65f24e304cacea90ce4f5fd6e7baad2a57195e82_389x292.jpg',
    ted_talk_url: 'http://www.ted.com/talks/paolo_cardini_forget_multitasking_try_monotasking.html',
    event_id: ted_global_2012.id,
    featured: true,
    viewable: true
  )

  paolo_cardini_talk_idea_1 = Idea.new(
    talks: [ paolo_cardini_talk ],
    description: 'Multi-tasking may be managed by only 2% of people, yet the technology that surrounds us puts us all too easliy into a multi-tasking state.',
    tags: ['Culture', 'Design', 'Humor', 'Product design', 'Technology'].map { | tag_name | Tag.find_by_name(tag_name) }
  )

  paolo_cardini_talk_idea_1.member = member1
  paolo_cardini_talk_idea_1.save!

  paolo_cardini_talk_idea_1.idea_actions.create!(description: 'Call someone instead of texting, and give your full attention.',
																								 member: member1, target_date: 1.week.from_now)
  paolo_cardini_talk_idea_1.idea_actions.create!(description: 'Visit Cardini\'s website and buy a phone cover to encourage mono tasking in your daily life and as a conversation-starter to enable sharing the idea with others.',
																								 member: member1, target_date: 1.week.from_now)

  paolo_cardini_talk_idea_2 = Idea.new(
    talks: [ paolo_cardini_talk ],
    description: 'Tecnhology-induced multi-tasking diminishes our experiences by distracting us from our immediate surroundings.',
    tags: ['Culture', 'Design', 'Humor', 'Product design', 'Technology'].map { | tag_name | Tag.find_by_name(tag_name) }
  )

  paolo_cardini_talk_idea_2.member = member1
  paolo_cardini_talk_idea_2.save!

  paolo_cardini_talk_idea_2.idea_actions.create!(description: 'Turn off your phone next time you are in a place that you wish to explore and experience it unmediated and uninterrupted by technology.  Allow yourself to get lost, if not literally in the place, then in the experience.',
																								 member: member2, target_date: 2.weeks.from_now)

  #
  # TEDx Houston
  #
  tedx_houston = Event.create!(
    name: 'TEDX Houston',
    description: 'In 2009, and in the spirit of ideas worth spreading, TED created a program called TEDx - A program of local, self-organized events that bring people together to share a TED-like experience. Our event is called TEDxHouston, where x = an independently organized TED event.',
    hero_image_url: 'http://media.tumblr.com/tumblr_m06bbd2h2q1qe2k72.jpg',
    featured: true
  )

  brene_brown_talk = Talk.create!(
    title: 'Brene Brown: The Power of Vulnerability', 
    description: 'Brene Brown studies human connection -- our ability to empathize, belong, love. In a poignant, funny talk, she shares a deep insight from her research, one that sent her on a personal quest to know herself as well as to understand humanity.',
    hero_image_url: 'http://images.ted.com/images/ted/4e1c25357f3ddd259c2eb15871337c2f0172f5a0_389x292.jpg',
    ted_talk_url: 'http://www.ted.com/talks/brene_brown_on_vulnerability.html',
    event_id: tedx_houston.id,
    featured: true
  )

  brene_brown_talk_idea_1 = Idea.new(
    talks: [ brene_brown_talk ],
    description: 'Connection is what gives our lives purpose and meaning - what life is all about.   People who experience deep connection are "whole-hearted" and embrace vulnerability as necessary to the authenticity that enables deep connection.  Denial of this vulnerability leads to numbing of all emotions, which hinders our relationships.',
    tags: ['Communication', 'Culture', 'Psychology', 'Self social change'].map { | tag_name | Tag.find_by_name(tag_name) },
    featured: true
  )

  brene_brown_talk_idea_1.member = member1
  brene_brown_talk_idea_1.save!

  brene_brown_talk_idea_1.idea_actions.create!(description: 'Make a list of emotions you find difficult and normally try to protect yourself from.  Try to welcome them.',
																							 member: member6, target_date: 2.weeks.from_now)
  brene_brown_talk_idea_1.idea_actions.create!(description: 'Talk to someone with whom you want to connect more deeply about these ideas - make room for vulnerability in the  relationship by becoming mutualy aware of it.',
																							 member: member7, target_date: 2.weeks.from_now)

  brene_brown_talk_idea_2 = Idea.new(
    talks: [ brene_brown_talk ],
    description: 'Feeling worthy of love and belonging leads to the capacity for compassion toward yourself, which is essential to having true compassion for others.  Shame is the fear of disconnection due to feeling unworthy.  Letting go of shame helps us to be more compassionate, whole-hearted beings.',
    tags: ['Communication', 'Culture', 'Psychology', 'Self social change'].map { | tag_name | Tag.find_by_name(tag_name) }
  )

  brene_brown_talk_idea_2.member = member1
  brene_brown_talk_idea_2.save!

  brene_brown_talk_idea_2.idea_actions.create!(description: 'Think of something you would do to show someone you love him or her.  Do it for yourself.',
																							 member: member6, target_date: 2.weeks.from_now)
  brene_brown_talk_idea_2.idea_actions.create!(description: 'Think "I am not _______ enough."  Thin?  Strong?  Smart?  Accomplished?  Now think of someone else you know who shares this trait.  Would you say that person does not deserve love or does not belong?  No.  Now give yourself the same compassion.',
																							 member: member7, target_date: 2.weeks.from_now)

  #
  # TEDx Beacon Street
  #
  tedx_beacon_street = Event.create!(
    name: 'TEDx Beacon Street',
    description: 'TEDxBeaconStreet is an exciting new conference that took place in the Greater Boston area on November 17 and 18, with a focus on fascinating speakers, captivating Adventures (which will continue throughout the next year), and a cross-generational audience, all in the service of Ideas In Action. There was no cost to attend the events.',
    hero_image_url: 'http://farm9.static.flickr.com/8289/7627278806_0101696503.jpg'
  )

  mitch_resnick_talk = Talk.create!(
    title: "Mitch Resnick: Let's teach kids to code", 
    description: "Coding isn't just for computer whizzes, says Mitch Resnick of MIT Media Lab -- it's for everyone. In a fun, demo-filled talk Resnick outlines the benefits of teaching kids to code, so they can do more than just \"read\" new technologies -- but also create them.",
    hero_image_url: 'http://i3.ytimg.com/vi/42_30Rgf6F0/mqdefault.jpg',
    ted_talk_url: 'http://www.ted.com/talks/mitch_resnick_let_s_teach_kids_to_code.html',
    event_id: tedx_beacon_street.id,
    viewable: true
  )

  mitch_resnick_talk_idea_1 = Idea.new(
    talks: [ mitch_resnick_talk ],
    description: 'Being comfortable with digital technologies does not necessarily make kids "digital natives."  They may be able to "read" in this language, but we must teach them to code if we want them to "write" as well and fully utilize the technology to express themselves.',
    tags: ['Children', 'Computers', 'Education', 'Internet', 'Parenting', 'Technology', 'Youth'].map { | tag_name | Tag.find_by_name(tag_name) }
  )

  mitch_resnick_talk_idea_1.member = member1
  mitch_resnick_talk_idea_1.save!

  mitch_resnick_talk_idea_1.idea_actions.create!(description: 'Go to scratch.mit.edu and make an interactive card for a friend.',
																								 member: member2, target_date: 4.weeks.from_now)
  mitch_resnick_talk_idea_1.idea_actions.create!(description: 'Choose a child in your life with whom to collaborate on making a game at scratch.mit.edu  Play it together.',
																								 member: member2, target_date: 4.weeks.from_now)

  mitch_resnick_talk_idea_2 = Idea.new(
    talks: [ mitch_resnick_talk ],
    description: 'Learning to code leads to coding to learn, and many transferrable academic and life skills may be acquired through the practice of coding, in large part because of its relationship to the design process.  This has great educational potential.',
    tags: ['Children', 'Computers', 'Education', 'Internet', 'Parenting', 'Technology', 'Youth'].map { | tag_name | Tag.find_by_name(tag_name) }
  )

  mitch_resnick_talk_idea_2.member = member1
  mitch_resnick_talk_idea_2.save!

  mitch_resnick_talk_idea_2.idea_actions.create!(description: 'Invite your local school board members or a principal or teacher in your community to listen to this TED talk and introduce kids to Scratch.',
																								 member: member2, target_date: 4.weeks.from_now)
  mitch_resnick_talk_idea_2.idea_actions.create!(description: 'Make a Scratch creation that demonstrates its value in some way, and share it through all your social media outlets.',
																								 member: member2, target_date: 4.weeks.from_now)

  #
  # TEDx Seoul
  #
  tedx_seoul = Event.create!(
    name: 'TEDx Seoul',
    description: 'TEDxSeoul is a platform where participants connect to each other around ideas and make social changes together for greater good. TEDxSeoul strives to be a community where all the participants, including the speakers, audiences and organizers, communicate on an eye-to-eye level sharing their passion and energy.',
    hero_image_url: 'http://images.ted.com/images/ted/e4d2470f139e9da9fb93f68013c231974f123af2_425x259.jpg'
  )

  young_ha_kim_talk = Talk.create!(
    title: "Young-ha Kim: Be an artist, right now!", 
    description: "With charm and humor, celebrated Korean author Young-ha Kim invokes the world's greatest artists to urge you to unleash your inner child -- the artist who wanted to play forever.",
    hero_image_url: 'http://images.ted.com/images/ted/98c37912ea62c89c21f43ef98ee122ebacd8634d_389x292.jpg',
    ted_talk_url: 'http://www.ted.com/talks/young_ha_kim_be_an_artist_right_now.html',
    event_id: tedx_seoul.id
  )

  young_ha_kim_talk_idea_1 = Idea.new(
    talks: [ young_ha_kim_talk ],
    description: 'As children, we are natural artists who sing, dance, draw, paint, and tell stories through our days, but as we grow, the artists within us are banished or locked in, but they do not go away.  Adults still have the natural artist within them, and it needs nourishment and freedom of expression.',
    tags: ['Arts', 'Creativity', 'Writing'].map { | tag_name | Tag.find_by_name(tag_name) }
  )

  young_ha_kim_talk_idea_1.member = member1
  young_ha_kim_talk_idea_1.save!

  young_ha_kim_talk_idea_1.idea_actions.create!(description: 'Make art.  Find a medium that interests you, and try it.  Use crayons, write a play or a poem.  It can be anything.  Search online for inspiration if it\'s difficult.  Enjoy the process, and don\'t worry about the product.  It is for you alone to share - or not.',
                                                featured: true, member: member3, target_date: 3.weeks.from_now)
  young_ha_kim_talk_idea_1.idea_actions.create!(description: 'Participate with a child in the creative process, without judgement and for the sheer joy of it.  Let him guide the process, and enjoy the ride.',
																								member: member3, target_date: 3.weeks.from_now)

  young_ha_kim_talk_idea_2 = Idea.new(
    talks: [ young_ha_kim_talk ],
    description: 'Many people do not believe they can be artistis, so suppressed is the artist within.  Activities that stay ahead of the judgemental thoughts that sabotage their efforts can help them realize their artistic abilities and, more importantly, the joy of artistic creativity.',
    tags: ['Arts', 'Creativity', 'Writing'].map { | tag_name | Tag.find_by_name(tag_name) }
  )

  young_ha_kim_talk_idea_2.member = member1
  young_ha_kim_talk_idea_2.save!

  young_ha_kim_talk_idea_2.idea_actions.create!(description: 'Do Kim\'s writing exercise.  Choose a theme such as either a joyful or difficult childhood experience, and "write like crazy" for an hour.  Don\'t stop to think, edit or review.  Just keep writing.  ',
																								member: member3, target_date: 3.weeks.from_now)

  #
  # TEDx Bloomington
  #
  tedx_bloomington = Event.create!(
    name: 'TEDx Bloomington',
    description: 'In the spirit of ideas worth spreading, TEDx is a program of local, self-organized events that bring people together to share a TED-like experience. At a TEDx event, TEDTalks video and live speakers combine to spark deep discussion and connection in a small group.',
    hero_image_url: 'http://farm3.staticflickr.com/2157/5720549498_2c062bfa33_z.jpg'
  )

  shawn_achor_talk = Talk.create!(
    title: "Shawn Achor: The happy secret to better work", 
    description: "We believe that we should work to be happy, but could that be backwards? In this fast-moving and entertaining talk, psychologist Shawn Achor argues that actually happiness inspires productivity.",
    hero_image_url: 'http://assets2.bigthink.com/system/idea_thumbnails/24080/original/2256923806_16a80a9a8a.jpg?1284855391',
    ted_talk_url: 'http://www.ted.com/talks/shawn_achor_the_happy_secret_to_better_work.html',
    event_id: tedx_bloomington.id,
    viewable: true
  )

  shawn_achor_talk_idea_1 = Idea.new(
    talks: [ shawn_achor_talk ],
    description: 'Only 10% of our long-term happiness is determined by external circumstances.  90% is determined by the way our brains process the world.  By taking simple steps to enhance happiness, we can alter the lens through which we see the world and effectively imporve our reality.',
    tags: ['Business', 'Happiness', 'Psychology', 'Science'].map { | tag_name | Tag.find_by_name(tag_name) }
  )

  shawn_achor_talk_idea_1.member = member1
  shawn_achor_talk_idea_1.save!

  shawn_achor_talk_idea_1.idea_actions.create!(description: 'Write 3 new things for which you are grateful every day for three weeks, and notice the way your mind starts to focus on the positive.',
																							 member: member1, target_date: 2.weeks.from_now)
  shawn_achor_talk_idea_1.idea_actions.create!(description: 'Write down your favorite experience each day in a journal - this enables your brain to experience it again, doubling the dopamine dose.',
																							 member: member1, target_date: 2.weeks.from_now)

  shawn_achor_talk_idea_2 = Idea.new(
    talks: [ shawn_achor_talk ],
    description: 'Our institutions and companies have it backward by operating as if success is a prerequisite of happiness when, in fact, happiness is a prerequisite of success.  The brain in a positive state is measurably more capable of learning, more productive and more creative.',
    tags: ['Business', 'Happiness', 'Psychology', 'Science'].map { | tag_name | Tag.find_by_name(tag_name) }
  )

  shawn_achor_talk_idea_2.member = member1
  shawn_achor_talk_idea_2.save!

  shawn_achor_talk_idea_2.idea_actions.create!(description: 'To enhance your positive state, commit an intentional act of kindness within your social circle, such as writing an email expressing gratitude or praising someone.  Try to make this a regular practice.',
																							 member: member2, target_date: 3.weeks.from_now)

  #
  # TED Salon NY2013
  #
  ted_salon_ny2013 = Event.create!(
    name: 'TED Salon NY2013',
    description: 'A TEDx Salon is a small weekly or monthly recurring event that keeps a TEDx community engaged between larger annual or bi-annual events.',
    hero_image_url: 'http://elianefersan.files.wordpress.com/2012/09/elle-speaking-at-tedx-salon1.jpeg?w=726'
  )

  esther_perel = Talk.create!(
    title: "Esther Perel: The secret to desire in a long-term relationship", 
    description: "In long-term relationships, we often expect our beloved to be both best friend and erotic partner. But as Esther Perel argues, good and committed sex draws on two conflicting needs: our need for security and our need for surprise. So how do you sustain desire? With wit and eloquence, Perel lets us in on the mystery of erotic intelligence.",
    ted_talk_url: 'http://www.ted.com/talks/esther_perel_the_secret_to_desire_in_a_long_term_relationship.html',
    event_id: ted_salon_ny2013.id,
    viewable: true
  )

  esther_perel_idea_1 = Idea.new(
    talks: [ esther_perel ],
    description: 'The key to sustaining desire in a committed relationshp is the reconciliation of the needs for both love and desire, which can be at odds with each other.  Three desire-enhancing elements stand out:  time apart; seeing your partner in his/her element, radiant; and experiencing novelty together.',
    tags: ['Culture' , 'Love', 'Relationships', 'Sex'].map { | tag_name | Tag.find_by_name(tag_name) }
  )

  esther_perel_idea_1.member = member1
  esther_perel_idea_1.save!

  esther_perel_idea_1.idea_actions.create!(description: 'Take that weekend away with the guys/girlfriends, going guilt-free and with the awareness between you and your partner that absence enhances desire.',
																					 member: member3, target_date: 3.months.from_now)
  esther_perel_idea_1.idea_actions.create!(description: 'Choose a new activity to share with your partner - go skydiving or to the zoo, play frisbee or a new board game.  Just have fun doing something new or that you have missed doing together for a long time.  Enjoy, and consider making it a regular practice to enjoy new things.',
																					 member: member3, target_date: 3.months.from_now)

  esther_perel_idea_2 = Idea.new(
    talks: [ esther_perel ],
    description: '"The myth of spontanaeity."  Let go of dependence on the idea that good sex must be spontaneous.  "Commited sex is premeditated sex."',
    tags: ['Culture' , 'Love', 'Relationships', 'Sex'].map { | tag_name | Tag.find_by_name(tag_name) }
  )

  esther_perel_idea_2.member = member1
  esther_perel_idea_2.save!

  esther_perel_idea_2.idea_actions.create!(description: 'Plan your next sexual encounter with your partner.  Talk about hat you might want.  Ask the same.  Combine it with a date doing something new together.',
																					 member: member1, target_date: 1.year.from_now)
  esther_perel_idea_2.idea_actions.create!(description: 'Choose one time a week for sex.  Enjoy the anticipation.',
																					 member: member1, target_date: 1.year.from_now)

  #
  # TEDx Toronto 2010
  #
  tedx_toronto_2010 = Event.create!(
    name: 'TEDx Toronto 2010',
    description: 'TEDxToronto is the largest TEDx conference in Toronto, Canada. The second annual conference took place on September 30, 2010 at Glenn Gould Studio with 12 TEDx Talks. It brought together the city\'s foremost thought leaders, change makers and everyday people from each discipline -- as speakers, attendees and enthusiasts.',
    hero_image_url: 'http://praxistheatre.com/wp-content/uploads/2012/10/TEDxToronto-Salon-Series.jpeg'
  )

  drew_dudley = Talk.create!(
    title: "Drew Dudley: Everyday leadership", 
    description: "We have all changed someone's life -- usually without even realizing it. In this funny talk, Drew Dudley calls on all of us to celebrate leadership as the everyday act of improving each other's lives.",
    hero_image_url: 'http://media.tumblr.com/tumblr_lnx1pukyjb1qedzgi.jpg',
    ted_talk_url: 'http://www.ted.com/talks/drew_dudley_everyday_leadership.html',
    event_id: tedx_toronto_2010.id,
    viewable: true
  )

  drew_dudley_idea_1 = Idea.new(
    talks: [ drew_dudley ],
    description: 'We have elevated leadership to something so unattainable that only those who change the world on a massive scale may claim to be leaders.  Doing so diminishes the everyday acts we commit that are, in fact, acts of leadership.',
    tags: ['Community', 'Leadership', 'Life', 'TEDxFeatured'].map { | tag_name | Tag.find_by_name(tag_name) }
  )

  drew_dudley_idea_1.member = member1
  drew_dudley_idea_1.save!

  drew_dudley_idea_1.idea_actions.create!(description: 'Ask yourself, "am I a leader?"  Note the feelings that arise.  Note who comes to your mind when you think "leader," and whether you accept yourself into that circle of people.',
																					member: member2, target_date: 1.month.from_now)
  drew_dudley_idea_1.idea_actions.create!(description: 'Identify someone who has made your life better.  Thank this person.',
																					member: member3, target_date: 1.month.from_now)

  drew_dudley_idea_2 = Idea.new(
    talks: [ drew_dudley ],
    description: 'As long as we make leadership something unattainable, we excuse ourselves from the responsibility of expecting it every day from ourselves and each other.',
    tags: ['Community', 'Leadership', 'Life', 'TEDxFeatured'].map { | tag_name | Tag.find_by_name(tag_name) }
  )

  drew_dudley_idea_2.member = member1
  drew_dudley_idea_2.save!

  drew_dudley_idea_2.idea_actions.create!(description: 'Write Marianne Williamson\'s quote down, and put it somewhere you will see it every day:  "Our greatest fear is not that we are inadequate.  Our greatest fear is that we are powerful beyond measure.  It is our light, and not our darkness, that frightens us."',
																					member: member4, target_date: 3.weeks.from_now)
  drew_dudley_idea_2.idea_actions.create!(description: 'Bring your awareness to leadership as happening in small everyday moments that need to be created and acknowledged.  Create them yourself, and acknowledge them in both yourself and others.',
																					member: member4, target_date: 3.weeks.from_now)

  #
  # TEDxThessaloniki
  #
  tedxthessaloniki = Event.create!(
    name: 'TEDxThessaloniki',
    description: 'TEDxThessaloniki brings the TED experience to Thessaloniki maintaining the non-profit nature and the innovative spirit of TED. The first event was held in 2010 and since then we have brought leading thinkers and practitioners to Greece, formed a community of thousands TEDxSters, whose main trait is their passion for change, and contribute a series of interesting and inspiring stories to the TEDx project.',
    hero_image_url: 'http://revoseek.com/wp-content/uploads/2012/05/TEDxThessaloniki-2012.jpg'
  )

  edi_rama = Talk.create!(
    title: "Edi Rama: Take back your city with paint", 
    description: "Make a city beautiful, curb corruption. Edi Rama took this deceptively simple path as mayor of Tirana, Albania, where he instilled pride in his citizens by transforming public spaces with colorful designs. With projects that put the people first, Rama decreased crime -- and showed his citizens they could have faith in their leaders.",
    hero_image_url: 'http://nimg.sulekha.com/others/original700/edi-rama-2009-11-20-14-11-56.jpg',
    ted_talk_url: 'http://www.ted.com/talks/edi_rama_take_back_your_city_with_paint.html',
    event_id: tedxthessaloniki.id,
    viewable: true
  )

  edi_rama_idea_1 = Idea.new(
    talks: [ edi_rama ],
    description: 'The creation of beauty in a city can change it for the better, even reducing crime rates at lower cost than employing a larger police force.  Beauty can stand as a guardsman, reducing litter and encouraging civic responsibility, such as paying taxes.',
    tags: ['Art', 'Cities', 'Community', 'Global issues', 'Government', 'Politics', 'Urban planning'].map { | tag_name | Tag.find_by_name(tag_name) }
  )

  edi_rama_idea_1.member = member1
  edi_rama_idea_1.save!

  edi_rama_idea_1.idea_actions.create!(description: 'Take more ownership of your public surroundings by picking up litter when you go out.',
																			 member: member5, target_date: 1.year.from_now)
  edi_rama_idea_1.idea_actions.create!(description: 'Notice your public surroundings and how thay make you feel.  Consider how important they might be to your community\'s attitudes toward itself.  Keep this in mind next time you have the opportunity to vote for or participate in a community improvement activity.',
																			 member: member5, target_date: 1.year.from_now)

  edi_rama_idea_2 = Idea.new(
    talks: [ edi_rama ],
    description: 'Environment has an impact on behavior, and changing an environment in the right way can impact behavior.  Systems and environment play important roles.  Corruption and other undesireable practices may be designed into and out of systems and places intentionally.',
    tags: ['Art', 'Cities', 'Community', 'Global issues', 'Government', 'Politics', 'Urban planning'].map { | tag_name | Tag.find_by_name(tag_name) }
  )

  edi_rama_idea_2.member = member1
  edi_rama_idea_2.save!

  edi_rama_idea_2.idea_actions.create!(description: 'Examine your assumptions about different people in the world.  Challenge the notion that culture or genes detemine things like degrees of corruption.',
																			 member: member5, target_date: 1.week.from_now)

  #
  # TEDActive
  #
  event = Event.create!(
    name: 'TEDActive',
    description: 'TEDActive is a curated community of 700 curious and energetic leaders who share an immersive week of TEDTalks and surprising experiences designed to inspire conversation, exchange and immediate action around ideas worth spreading.',
    logo_image_url: 'http://conferences.ted.com/TEDActive2013/images/logo.png?20091208',
    hero_image_url: 'http://conferences.ted.com/TED2013/images/auditions/talentsearch_f.jpg',
  )

  amy_cuddy_talk = Talk.create!(
    title: 'Amy Cuddy: Your body language shapes who you are', 
    description: 'Body language affects how others see us, but it may also change how we see ourselves. Social psychologist Amy Cuddy shows how "power posing" -- standing in a posture of confidence, even when we don\'t feel confident -- can affect testosterone and cortisol levels in the brain, and might even have an impact on our chances for success.',
    hero_image_url: 'http://images.ted.com/images/ted/a50e3b4c7ba8e8476731498682c169ac07ccae5b_389x292.jpg',
    ted_talk_url: 'http://www.ted.com/talks/amy_cuddy_your_body_language_shapes_who_you_are.html',
    event_id: event.id,
    viewable: true
  )

  amy_cuddy_idea = Idea.new(
      talks: [ amy_cuddy_talk ],
      description: 'Body language affects how others see us, but it may also change how we see ourselves',
      tags: %w(Brain Business Psychology Self Success).map { | tag_name | Tag.find_by_name(tag_name) }
  )
  amy_cuddy_idea.member = member1
  amy_cuddy_idea.save!

  amy_cuddy_idea.idea_actions.create!(:description => 'Examine your own body language in different social situations.',
																			member: member6, target_date: 3.weeks.from_now)

  steve_jobs_talk = Talk.create!(
    title: 'Steve Jobs: How to live before you die', 
    description: 'At his Stanford University commencement speech, Steve Jobs, CEO and co-founder of Apple and Pixar, urges us to pursue our dreams and see the opportunities in life\'s setbacks -- including death itself.',
    ted_talk_url: 'http://www.ted.com/talks/steve_jobs_how_to_live_before_you_die.html',
    event_id: event.id
  )

  amy_cuddy_and_steve_jobs_idea = Idea.new(
    talks: [ amy_cuddy_talk, steve_jobs_talk ],
    description: 'Power posing can affect testosterone and cortisol levels in the brain, may impact on our chances for success.',
    tags: %w(Brain Business Psychology Self Success).map { | tag_name | Tag.find_by_name(tag_name) }
  )

  amy_cuddy_and_steve_jobs_idea.member = member1
  amy_cuddy_and_steve_jobs_idea.save!

  amy_cuddy_and_steve_jobs_idea.idea_actions.create!(:description => 'Power-pose for two minutes before an important meeting.',
																										 member: member7, target_date: 3.weeks.from_now)

end