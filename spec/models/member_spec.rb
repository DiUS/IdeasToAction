require 'spec_helper'

describe Member do
  before(:each) do
    activate_authlogic
    @member = Member.first
  end

  it "should allow blank user names and passwords" do
    @member.username = ""
    @member.password = ""
    @member.valid?.should be_true
  end
end