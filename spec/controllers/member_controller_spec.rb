require 'spec_helper'

describe MemberController do
  let(:member) { Member.first }
  let(:interactions) { [Interaction.first, Interaction.last] }

  before do
    controller.stub!(:member).and_return(member)
    Interaction.stub!(:find_by_member).with(member).and_return(interactions)
  end

  describe "GET interactions" do
    it "responds with member interactions and dependant idea actions" do
      get :interactions
      
      response_interactions = JSON.parse(response.body)
      response_interactions.size.should eql 2

      response_interactions.first['id'].should eql interactions.first.id
      response_interactions.first['idea_action']['id'].should eql interactions.first.idea_action.id.as_json

      response_interactions.last['id'].should eql interactions.last.id
      response_interactions.last['idea_action']['id'].should eql interactions.last.idea_action.id.as_json
    end
  end
end
