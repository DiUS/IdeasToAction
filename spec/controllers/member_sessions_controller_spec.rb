require 'spec_helper'

describe MemberSessionsController do
  before :each do
    activate_authlogic
    @admin_member = Member.create!(:username => "ted", :password => "admin")
  end

  it "should login a user" do
    post :create, :member_session => { :username => "ted", :password => "admin", :format => 'json' }
    assigns(:member_session).record.should eql(@admin_member)
    response.should be_success
  end

  it "should not login an invalid user" do
    post :create, :member_session => { :username => "invalid_username", :password => "invalid_password", :format => 'json' }
    assigns(:member_session).record.should_not eql(@admin_member)
    response.should_not be_success
  end

  it "should logout the user" do
    delete :destroy, {:id => @admin_member.id}
    ActiveSupport::JSON.decode(response.body)["success"].should be_true
    response.should be_success
  end

  it "should report user status" do
    get :check

    ActiveSupport::JSON.decode(response.body)["admin_authenticated"].should be_true
    ActiveSupport::JSON.decode(response.body)["id"].should eql(@admin_member.id)
    ActiveSupport::JSON.decode(response.body)["username"].should eql(@admin_member.username)

    response.should be_success
  end
end