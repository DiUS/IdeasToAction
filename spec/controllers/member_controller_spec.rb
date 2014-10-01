require 'spec_helper'

describe MemberController do
  let(:member) { Member.first }

	before do
		controller.stub(:current_member).and_return(member)
		get :idea_actions
	end

	describe 'GET idea_actions' do
		it 'should be successful' do
			expect(response).to be_success
		end
	end
end
