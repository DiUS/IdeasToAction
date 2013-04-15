require 'spec_helper'

describe Talk do

  it { should be_accessible(:description) }
  it { should be_accessible(:title) }
  it { should be_accessible(:ideas) }
  it { should be_accessible(:hero_image_url) }
  it { should be_accessible(:ted_talk_url) }
  it { should be_accessible(:featured) }
  it { should be_accessible(:event_id ) }

  it { should delegate(:name).to(:event).with_prefix }
  it { should have_many(:ideas).through(:talk_to_idea_associations) }

  it { should validate_presence_of(:event) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  it 'should return featured talks' do
    talks = Talk.featured
    talks.each{|talk| talk.featured?.should be_true}
  end

  it 'should return recent talks' do
    talks = Talk.recent
    talks.should include(Talk.order("created_at desc").first)
  end

  it 'should return popular talks' do
    talks = Talk.popular
    talks.should include(Talk.order("idea_actions_count desc").first)
  end

  it 'should exclude specified talk' do
    talks_to_exclude = Event.first
    Talk.excluding_talks([talks_to_exclude.id]).should_not include(talks_to_exclude)
  end

  context 'dependent ideas' do
    before :each do
      @talk = Talk.create!(:event_id => Event.first.id, :title => "test", :description => "talk", :hero_image_url => "test")
      @idea = Idea.create!(:talks => [@talk], :member_id => Member.first.id, :description => "test idea")
    end

    it 'should destroy dependent ideas if they are not associated with other talks' do
      expect { @talk.destroy }.to change{ Idea.count }.by(-1)
    end

    it 'should not destroy dependent ideas if they are associated with other talks' do
      @idea.talks << Talk.first
      @idea.save
      expect { @talk.destroy }.not_to change{ Idea.count }
    end
  end
end
