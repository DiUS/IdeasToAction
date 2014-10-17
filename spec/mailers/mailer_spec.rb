require 'spec_helper'

describe Mailer do
  let(:idea_action){double(IdeaAction, description: 'description', update_attribute: true)}
  let(:remindable_actions){[idea_action]}
  let(:mail){Mailer.remind(member)}
  subject{mail}

  describe "self.welcome" do
    let(:member){double(Member, email: 'to.1@example.org')}
    let(:mail){Mailer.welcome(member)}
    subject{mail}

    its(:subject){should match('TEDxUltimo Welcome')}
    its(:to){should eq(['to.1@example.org'])}
    its(:from){should eq(["no-reply+test@tedxultimo.com"])}

    describe "#body" do
      subject{mail.body.encoded}
      it{should match('Welcome to TEDxUltimo')}
    end
  end

  context "member.remindable? == true" do
    let(:member){double(Member, email: 'to.0@example.org', remindable?: true, remindable_actions: remindable_actions)}

    describe "self.remind" do
      its(:subject){should match('TEDxUltimo Reminder')}
      its(:to){should eq(['to.0@example.org'])}
      its(:from){should eq(["no-reply+test@tedxultimo.com"])}

      describe "#body" do
        subject{mail.body.encoded}
        it{should match('This is a reminder email')}
      end
    end

    describe "self.reminders" do
    end
  end

  context "member.remindable? == false" do
    let(:member){double(Member, email: 'to@example.org', remindable?: false, remindable_actions: remindable_actions)}

    describe "self.remind" do
      it "must be a null mail object" do
        expect(subject.class).to be ActionMailer::Base::NullMail
      end
    end

    describe "self.reminders" do
    end
  end

end
