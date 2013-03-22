  # describe 'POST react' do
  #   let(:member) { mock_model Member }
  #   let(:idea_action) { mock_model IdeaAction }

  #   before :each do
  #     IdeaAction.should_receive(:find).and_return idea_action
  #     controller.stub(:member).and_return member
  #   end

  #   it 'creates a reaction' do
  #     Reaction.should_receive(:create!).with(:idea_action => idea_action, :member => member, :text => 'this is my reaction')
  #     post :react, {:id => 1, :text => 'this is my reaction', :format => 'json'}, valid_session 
  #   end
  # end

  # describe 'POST doneIt' do
  #   let(:member) { mock_model Member }
  #   let(:idea_action) { mock_model IdeaAction }

  #   before :each do
  #     IdeaAction.should_receive(:find).and_return idea_action
  #     controller.stub(:member).and_return member
  #   end

  #   it 'creates an actions taken entry' do
  #     Interaction.should_receive(:create!).with(:member => member, :idea_action => idea_action)
  #     post :doneIt, {:id => 1, :format => 'json'}, valid_session 
  #   end
  # end