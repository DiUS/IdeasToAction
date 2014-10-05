require 'spec_helper'

describe Member do
	it { should have_many(:idea_actions) }

	describe 'credentials' do
		before(:each) do
			activate_authlogic
			@member = Member.first
		end

		it 'should allow blank user names and passwords' do
			@member.email = ''
			@member.password = ''
			@member.valid?.should be_true
		end
	end
end