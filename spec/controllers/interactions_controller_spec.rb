require 'spec_helper'

describe InteractionsController do
  describe "POST create" do
    let(:member) { mock_model Member }

    before do
      controller.stub(:member).and_return member
    end

    it 'should create a new Interaction' do
      Interaction.should_receive(:create!).with(:idea_action_id => '1', :member => member)
      post :create, { :format => 'json', :idea_action_id => '1' }
    end
  end
end