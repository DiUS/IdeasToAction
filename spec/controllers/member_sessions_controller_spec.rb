require 'spec_helper'

describe MemberSessionsController do

  before :each do
    activate_authlogic
    @admin_member = Member.create!(email: 'ted@x.com', password: 'admin')
  end

  describe "when round trip" do
    it "should login a user" do
      post :create, member_session: {email: 'ted@x.com', password: 'admin'}
      assigns(:member_session).record.should eql(@admin_member)
      response.should be_redirect
    end

    it "should not login an invalid user" do
      post :create, member_session: {email: 'invalid_email', password: 'invalid_password', format: 'json' }
      assigns(:member_session).record.should_not eql(@admin_member)
    end

    it "should logout the user" do
      delete :logout, {id: @admin_member.id}
      response.should be_redirect
    end
  end

  describe "when json/ajax" do
    it "should report user status" do
      xhr :get, :check
      ActiveSupport::JSON.decode(response.body)['admin_authenticated'].should be_true
      ActiveSupport::JSON.decode(response.body)['id'].should eql(@admin_member.id)
      ActiveSupport::JSON.decode(response.body)['email'].should eql(@admin_member.email)
      response.should be_success
    end

    it "should login a user" do
      xhr :post, :create, member_session: {email: 'ted@x.com', password: 'admin'}, format: :json
      assigns(:member_session).record.should eql(@admin_member)
      response.should be_success
    end

    it "should not login an invalid user" do
      xhr :post, :create, member_session: {email: 'invalid_email', password: 'invalid_password'}, format: :json
      assigns(:member_session).record.should_not eql(@admin_member)
    end

    it "should logout the user" do
      xhr :delete, :logout, {id: @admin_member.id, format: :json}
      ActiveSupport::JSON.decode(response.body)["success"].should be_true
      response.should be_success
    end
	end

	describe 'when non existent member' do
		let(:new_member) { double(Member) }

		it 'should create a new user and send welcome email' do
			Member.should_receive(:create).and_return(new_member)
			Mailer.should_receive(:welcome).with(new_member)
			post :create, member_session: { email: 'new@member.com', password: 'tedxer' }
		end
	end

end
