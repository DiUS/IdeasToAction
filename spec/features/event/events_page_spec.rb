describe "Events page", js: true, acceptance: true do
  
  let(:events) { {'featured' => [{ 
      "created_at" => "2013-03-22T04:48:19Z",
      "description" => "As the world becomes interconnected, the ways we relate and learn about one another (and the rules about what we share) are changing. That was the inspiration for TEDGlobal 2012: Radical Openness, held in Edinburgh.",
      "featured" => false,
      "hero_image_url" => "http://farm8.staticflickr.com/7253/7450449710_23216321ae_z.jpg",
      "id" => 28,
      "logo_image_url" => nil,
      "name" => "TED Global 2012",
      "updated_at" => "2013-03-22T04:48:19Z"
    }],
    'random' =>  [{ 
      "created_at" => "2013-03-22T04:48:19Z",
      "description" => "In 2009, and in the spirit of ideas worth spreading, TED created a program called TEDx - A program of local, self-organized events that bring people together to share a TED-like experience. Our event is called TEDxHouston, where x = an independently organized TED event.",
      "featured" => true,
      "hero_image_url" => "http://media.tumblr.com/tumblr_m06bbd2h2q1qe2k72.jpg",
      "id" => 29,
      "logo_image_url" => nil,
      "name" => "TEDX Houston",
      "updated_at" => "2013-03-22T04:48:19Z"
    },
    { 
      "created_at" => "2013-03-22T04:48:19Z",
      "description" => "TEDxBeaconStreet is an exciting new conference that took place in the Greater Boston area on November 17 and 18, with a focus on fascinating speakers, captivating Adventures (which will continue throughout the next year), and a cross-generational audience, all in the service of Ideas In Action. There was no cost to attend the events.",
      "featured" => false,
      "hero_image_url" => "http://farm9.static.flickr.com/8289/7627278806_0101696503.jpg",
      "id" => 30,
      "logo_image_url" => nil,
      "name" => "TEDx Beacon Street",
      "updated_at" => "2013-03-22T04:48:19Z"
    }],
    'popular' =>  [{ 
      "created_at" => "2013-03-22T04:48:20Z",
      "description" => "TEDxSeoul is a platform where participants connect to each other around ideas and make social changes together for greater good. TEDxSeoul strives to be a community where all the participants, including the speakers, audiences and organizers, communicate on an eye-to-eye level sharing their passion and energy.",
      "featured" => false,
      "hero_image_url" => "http://images.ted.com/images/ted/e4d2470f139e9da9fb93f68013c231974f123af2_425x259.jpg",
      "id" => 31,
      "logo_image_url" => nil,
      "name" => "TEDx Seoul",
      "updated_at" => "2013-03-22T04:48:20Z"
    },
    { 
      "created_at" => "2013-03-22T04:48:20Z",
      "description" => "In the spirit of ideas worth spreading, TEDx is a program of local, self-organized events that bring people together to share a TED-like experience. At a TEDx event, TEDTalks video and live speakers combine to spark deep discussion and connection in a small group.",
      "featured" => false,
      "hero_image_url" => "http://farm3.staticflickr.com/2157/5720549498_2c062bfa33_z.jpg",
      "id" => 32,
      "logo_image_url" => nil,
      "name" => "TEDx Bloomington",
      "updated_at" => "2013-03-22T04:48:20Z"
    }]} }

  before do
    visit "#/events"
  end

  describe 'featured event' do
    let (:featured) { events['featured'].first }
    let (:featured_element) { page.find('.content:first') }

    it 'should show' do
      featured_element.should have_content 'FEATURED EVENT'
      featured_element.should have_content featured['name']
      featured_element.should have_content featured['description']
      featured_element.should have_selector 'img'
    end

    it 'should show total' do
      featured_element.should have_content '14 ideas'
      featured_element.should have_content '12 actions'
      featured_element.should have_content '19 reactions'
    end
  end

  describe 'other events' do
    let (:other) { events['popular'] + events['random'] }
    let (:other_elements) { page.all('.content:not(:first)') }

    it 'should show' do
      other.to_enum.with_index(0).each do | event, index |
        other_elements[index].should have_content event['name']
      end
    end

    it 'should show total' do
      other.to_enum.with_index(0).each do | event, index |
        other_elements[index].should have_content '4 ideas'
        other_elements[index].should have_content '12 actions'
        other_elements[index].should have_content '19 reactions'
      end
    end
  end

  describe 'when wanting to navigate back to the home page' do
    before do
      page.should_not have_selector('#home')
      page.first('.header .touch-icon').click
    end

    it 'should navigate back to home' do
      page.should have_selector('#home')
    end
  end
end