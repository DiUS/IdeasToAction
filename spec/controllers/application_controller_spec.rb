describe ApplicationController do

  context "#member_session" do

    before :each do
      controller.instance_variable_get(:@member_session).should be nil
    end

    it "should try to find an existing member session" do
      MemberSession.should_receive(:find).and_return(:a_session)

      controller.member_session.should be :a_session
    end

    context "when no member session exists" do

      before :each do
        MemberSession.stub(:find).and_return(nil)        
      end

      it "should create a new one with a new member and reutrn it" do
        Member.should_receive(:create!).and_return(:member)
        MemberSession.should_receive(:create).with(:member, true).and_return(:a_session)

        controller.member_session.should be :a_session
      end

    end

    context "when a member session exists" do

      before :each do
        MemberSession.stub(:find).and_return(:a_session)        
      end

      it "should return it" do
        controller.member_session.should be :a_session
      end
    end

    after :each do
      controller.instance_variable_get(:@member_session).should_not be nil
    end
  end

  context "#member" do

    it "should retrieve it from the member session" do

    end
  end
end

