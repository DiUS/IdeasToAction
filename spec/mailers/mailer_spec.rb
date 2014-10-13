require 'spec_helper'

describe Mailer do
  let(:idea_action){double(IdeaAction, description: 'description', update_attribute: true)}
  let(:remindable_actions){[idea_action]}
  let(:mail){Mailer.remind(member)}
  subject{mail}

  context "member.remindable? == true" do
    let(:member){double(Member, email: 'to@example.org', remindable?: true, remindable_actions: remindable_actions)}

    describe "self.remind" do
      its(:subject){should match('TEDx Reminder')}
      its(:to){should eq(['to@example.org'])}
      its(:from){should eq(["no-reply+test@tedxultimo.com"])}

      describe "#body" do
        subject{mail.body.encoded}
        it{should match('OMG, the target date for the following action')}
      end
    end

    describe "self.reminders" do
    end
  end

  context "member.remindable? == false" do
    let(:member){double(Member, email: 'to@example.org', remindable?: false, remindable_actions: remindable_actions)}

    describe "self.remind" do
      it "must be null mail object" do
        expect(subject.class).to be ActionMailer::Base::NullMail
      end
    end

    describe "self.reminders" do
    end
  end

end
