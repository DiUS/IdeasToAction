require_relative 'collapsible_shared_examples'

describe "Idea submission page", js: true, acceptance: true do
  
  let(:talk) { Talk.find(1) }

  before :each do
    talk.should_not be_nil
    visit "/assets/index.html#/ideas/new/inspiredByTalk/1"
    header.click
  end

  context "Inspired by collapsible" do
    let(:title) { "Inspired by..." }
    let(:item_contents) { [ talk.title ] }

    let (:starts_as_collapsed?) { false }

    it_should_behave_like "a collapsible"
  end

end