require 'spec_helper'

describe IdeaActionsController do

  def valid_session
    {}
  end

  def valid_attributes
    {}
  end

  describe 'GET random' do
    it 'gets featured ideas' do
      action = IdeaAction.featured.first
      IdeaAction.stub_chain(:featured, :random).and_return [action]
      get :random, { :format => :json }
      response.body.should eql action.to_json
    end
  end

  describe 'GET index' do
    describe "when nesting" do
      it 'gets nothing without mix param' do
        get :index, { :idea_id => 1, :format => 'json' }, valid_session
        response.body.should be_blank
        response.should be_success
      end

      it 'gets events when mix is set to true' do
        get :index, { :idea_id => 1, :format => 'json', :mix => 'true' }, valid_session
        response.body.should_not be_blank
        response.should be_success
        assigns(:idea_action_view).should_not be_nil
      end

      describe 'excluding certain idea_actions' do
        let(:idea_action_ids) { '1,2,3,4,5' }
        let(:idea_actions) { ['idea_action1', 'idea_action2'] }
        let(:excluded_idea_actions) { mock('excluded_idea_actions') }

        before do
          IdeaAction.should_receive(:excluding_idea_actions).with(idea_action_ids.split(',')).and_return(excluded_idea_actions)
          excluded_idea_actions.should_receive(:random).with(5).and_return(idea_actions)
          get :index, {:format => 'json', :excluding => idea_action_ids}, valid_session
        end

        it 'gets idea_actions excluding the list provided in the params' do
          response.body.should eql idea_actions.to_json
          response.should be_success
        end
      end
    end

    describe "without nesting" do
      it 'gets nothing without mix param' do
        get :index, { :format => 'json' }, valid_session
        response.body.should be_blank
        response.should be_success
      end

      it 'gets events when mix is set to true' do
        get :index, { :format => 'json', :mix => 'true' }, valid_session
        response.body.should_not be_blank
        response.should be_success
        assigns(:idea_action_view).should_not be_nil
      end
    end
	end

	describe 'POST create' do
		before do
			controller.stub(:current_member).and_return(Member.first)
		end

		describe 'with valid attributes' do
			let(:valid_attributes) { { description: 'This is the action I want to do', target_date: Time.now + 1.day, idea_id: Idea.first.id } }

			before do
				post :create, { :format => 'json', :idea_action => valid_attributes}
			end

			it 'should be successful' do
				expect(response).to be_success
			end

			it 'should create a new idea action' do
				expect(assigns(:idea_action)).to be_a(IdeaAction)
				expect(assigns(:idea_action)).to be_persisted
			end

			it 'returns JSON of new created idea action' do
				idea_action_json = JSON.parse(response.body)
				expect(idea_action_json['description']).to eq(valid_attributes[:description])
			end
		end

		describe 'with invalid attributes' do
			let(:invalid_attributes) { { description: '', idea_id: Idea.first.id } }

			before do
				post :create, { :format => 'json', :idea_action => invalid_attributes}
			end

			it 'should not be successful' do
				expect(response).not_to be_success
			end

			it 'should be an unprocessable entity' do
				expect(response.status).to eq(422)
			end

			it 'should contain errors' do
				idea_action_json = JSON.parse(response.body)
				expect(idea_action_json['errors']).to eq(assigns(:idea_action).errors.messages.stringify_keys)
			end
		end
	end

	describe 'PUT complete' do
		let(:idea_action) { IdeaAction.first }

		describe 'for users that submitted the action' do
			describe 'when ok' do
				before do
					controller.stub(:current_member).and_return(idea_action.member)
					put :complete, { id: idea_action.id, format: :json }
				end

				it 'should be successful' do
					expect(response).to be_success
				end

				it 'should update new idea action' do
					expect(assigns(:idea_action)).to be_a(IdeaAction)
					expect(assigns(:idea_action)).to be_persisted
				end

				it 'returns JSON of updated idea action' do
					idea_action_json = JSON.parse(response.body)
					expect(idea_action_json['description']).to eq(idea_action.description)
				end
			end

			describe 'when error' do
				let(:errors) { ['error'] }

				before do
					IdeaAction.any_instance.stub(:save).and_return(false)
					IdeaAction.any_instance.stub(:errors).and_return(errors)
					controller.stub(:current_member).and_return(idea_action.member)
					put :complete, { id: idea_action.id, format: :json }
				end

				it 'should not be successful' do
					expect(response).not_to be_success
				end

				it 'returns JSON with errors' do
					error_response = JSON.parse(response.body)
					expect(error_response['errors']).to eq(errors)
				end
			end
		end
	end
end
