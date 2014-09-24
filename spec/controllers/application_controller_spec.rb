describe ApplicationController do

  context "#member_session" do

    context "@member_session is not nil" do
      before :each do
        controller.instance_variable_set(:@member_session, double(MemberSession))
      end

      it "should return it" do
        member_session = controller.instance_variable_get(:@member_session)
        controller.should_receive(:member_session).and_return(member_session)
        controller.send(:member_session).should be member_session
      end
    end

    context "@member_session is nil" do
      before :each do
        controller.instance_variable_get(:@member_session).should be nil
      end

      context "when there is a member session" do
        before :each do
          MemberSession.stub(:find).and_return(:a_session)
        end

        it "should return it" do
          controller.send(:member_session).should be(:a_session)
        end
      end

      context "when there is no member session" do
        before :each do
          MemberSession.stub(:find).and_return(nil)
        end

        it "should create a new member session with a new member and return it" do
          Member.should_receive(:create!).and_return(:member)
          MemberSession.should_receive(:create).with(:member, true).and_return(:a_session)
          controller.send(:member_session).should be :a_session
        end
      end
    end

    after :each do
      controller.instance_variable_get(:@member_session).should_not be nil
    end
  end # context "#member_session"

  context "#member" do
    let(:member_session){double(MemberSession)}

    context "@member is not nil" do
      before :each do
        member_session.stub(:record).and_return(:a_member)
        controller.instance_variable_set(:@member, :a_member)
      end

      it "should return it" do
        member = controller.instance_variable_get(:@member)
        controller.should_receive(:member).and_return(member)
        controller.send(:member).should be member
      end
    end

    context "@member is nil" do
      before :each do
        member_session.stub(:record).and_return(:a_member)
      end

      it "should assign @member" do
        controller.should_receive(:member_session).twice.and_return(member_session)
        controller.send(:member).should be :a_member
      end
    end

    after :each do
      controller.instance_variable_get(:@member).should_not be nil
    end
  end # context "#member"

end
