require 'spec_helper'

describe MemberController do
  let(:member)   { Member.create! }

  before do
    ActionsTaken.create! :member => member, :idea_action => IdeaAction.create!
    Reaction.create! idea_action: IdeaAction.first, :member => member, :text => 'what else can I say?'
    controller.stub!(:member).and_return(member)
  end

  describe "GET show" do
    it "responds with member" do
      get :show
      response.body.should eql member.to_json
    end
  end

  describe "GET actions" do
    it "responds with member actions" do
      get :actions
      response.body.should eql member.idea_actions.to_json
    end
  end

  describe "GET reactions" do
    it "responds with member actions" do
      get :reactions
      response.body.should eql member.reactions.to_json
    end
  end
end
