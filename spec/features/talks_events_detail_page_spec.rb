require_relative 'collapsible_shared_examples'

describe "Talks Events detail page", js: true, acceptance: true do
  
  let(:events) { Event.all }
  let(:talks) { Talk.all }

  before :each do
    visit "/assets/index.html#/talks-events"
  end

  context "Talks collapsible" do
    let(:title) { "Talks" }
    let(:item_contents) { talks.map(&:title) }

    it_should_behave_like "a collapsible"
  end

  context "Events collapsible" do
    let(:title) { "Events" }
    let(:item_contents) { events.map(&:name) }

    it_should_behave_like "a collapsible"
  end

end