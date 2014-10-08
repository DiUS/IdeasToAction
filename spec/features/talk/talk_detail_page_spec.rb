require_relative '../collapsible_shared_examples'

describe "Talk detail page", js: true, acceptance: true do
  
  let(:talk) { Talk.find(1) }
  let(:idea) { talk.ideas.first }

  before :each do
    talk.should_not be_nil
    visit "/#/events/1/talks/1"
  end

  it "should have the talk details visible" do
    page.should have_content talk.title
    page.should have_content talk.description

    page.should have_content "Ideas#{talk.ideas.size}"
  end

  it 'should have an external link to the TED talk' do
    a = page.find("[text()='View this talk on TED.com']")
    a['phonegap-external'].should eql talk.ted_talk_url
  end

  context "Ideas collapsible" do
    let(:title){"Ideas"}
    let(:item_contents){talk.ideas.map(&:description)}

    it_should_behave_like 'a collapsible'
  end
end