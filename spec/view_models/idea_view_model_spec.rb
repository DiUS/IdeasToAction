require 'spec_helper'

describe IdeaViewModel do
  let(:idea_view_model) { IdeaViewModel.new params }

  describe 'when creating an idea view model based on a view and member' do
    let(:idea)   { Idea.first }
    let(:member) { mock_model Member }
    let(:params) { { :id => idea.id, :member => member } }

    before :each do
      Idea.should_receive(:find).with(params[:id]).and_return idea
    end

    it 'should return an idea' do
      idea_view_model.as_json['id'].should eql idea.id
    end

    it 'should associate actions' do
      idea.actions.should_not be_empty
      idea_view_model.as_json['actions'].size.should eql idea.actions.size
    end

    describe 'for each action in associated with the idea' do
      let(:time) { DateTime.new }
      let(:first_action) { mock_model(Action) }
      let(:first_action_json) { idea_view_model.as_json['actions'].first }
      let(:member_action_taken) { mock_model ActionsTaken, :created_at => time }

      before :each do 
        idea.should_receive(:actions).and_return [ first_action ]
        actions_taken = [ mock_model(ActionsTaken) ]
        first_action.should_receive(:actions_taken).and_return(actions_taken)
        actions_taken.should_receive(:from_member).with(member).and_return member_action_taken

        member_action_taken.stub(:as_json).and_return({ :actions_taken => 'stuff' })
      end

      it 'should associate the member action taken' do
        first_action_json['member_action_taken'].should eql member_action_taken.as_json
      end

      it 'should change created at to be nicely formatted' do
        first_action_json['member_action_taken']['created_at'].should eql time.strftime("%b %d %Y")
      end
    end

    it 'should associate reactions' do
      idea.reactions.should_not be_empty
      idea_view_model.as_json['reactions'].size.should eql idea.reactions.size
    end

    describe 'for each reaction associated with the idea' do
      let(:first_reaction) { mock_model(Reaction) }
      let(:first_reaction_json) { idea_view_model.as_json['reactions'].first }

      before :each do 
        idea.should_receive(:reactions).and_return [ first_reaction ]
        first_reaction.stub(:as_json).and_return({ :reaction => 'stuff' })
      end

      it 'should as_json each reaction' do
        first_reaction_json.should eql ({ :reaction => 'stuff' })
      end
    end
  end
end
