require 'spec_helper'

describe Talk do

  it { should be_accessible(:description) }
  it { should be_accessible(:title) }
  it { should be_accessible(:ideas) }
  it { should be_accessible(:hero_image_url) }
  it { should be_accessible(:ted_talk_url) }
  it { should be_accessible(:featured) }
  it { should be_accessible(:viewable) }
  it { should be_accessible(:event_id ) }

  it { should delegate(:name).to(:event).with_prefix }
  it { should have_many(:ideas).through(:talk_to_idea_associations) }

  it { should validate_presence_of(:event) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  describe "collection methods" do
    describe "self.random" do
      subject{Talk}

      it "should return random talks" do
        member_objects = []
        100.times{member_objects << subject.random}
        expect(member_objects.frequencies.values.max).to be <= 100/subject.count * 3
      end

      it "should return a given number of random talks" do
        expect(subject.random(2).count).to eq 2
      end
    end

    describe "self.featured" do
      it 'should return featured talks' do
        talks = Talk.featured
        talks.each{|talk| talk.featured?.should be_true}
      end
    end

    describe "self.recent" do
      it 'should return recent talks' do
        talks = Talk.recent
        talks.should include(Talk.order("created_at desc").first)
      end
    end

    describe "self.popular" do
      it 'should return popular talks' do
        talks = Talk.popular
        talks.should include(Talk.order("idea_actions_count desc").first)
      end
    end

    describe "self.excluding_talks" do
      it 'should exclude specified talk' do
        talks_to_exclude = Event.first
        Talk.excluding_talks([talks_to_exclude.id]).should_not include(talks_to_exclude)
      end
    end

    describe "self.viewable" do
      it "should return viewable talks" do
        talks = Talk.viewable
        talks.each{|talk| talk.viewable?.should be_true}
      end
    end

    describe "self.total" do
      it "should be a number" do
        expect(Talk.total.class).to eq Fixnum
      end
    end
  end

  describe "member methods" do
    describe "destroy_ideas_without_talks" do
      before do
        @talk = Talk.create!(event_id: Event.first.id, title: "talk title 0", description: "talk description 0", hero_image_url: "test")
        @idea = Idea.create!(talks: [@talk], member_id: Member.first.id, description: "test idea 0")
      end

      it "should destroy ideas without talks" do
        @talk.should_receive(:destroy_ideas_without_talks)
        @talk.destroy
      end
    end
  end

  context 'dependent ideas' do
    before :each do
      @talk = Talk.create!(event_id: Event.first.id, title: "talk title 1", description: "talk description 1", hero_image_url: "test")
      @idea = Idea.create!(talks: [@talk], member_id: Member.first.id, description: "test idea")
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
