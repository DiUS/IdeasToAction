require 'spec_helper'

describe Mailer do

  describe ".remind" do
    let(:idea_action){double(IdeaAction, description: 'description', update_attribute: true)}
    let(:remindable_actions){[idea_action]}
    let(:member){double(Member, email: 'to@example.org', remindable?: true, remindable_actions: remindable_actions)}
    let(:mail){Mailer.remind(member)}
    subject{mail}

    its(:subject){should match('TEDx Reminder')}
    its(:to){should eq(['to@example.org'])}
    its(:from){should eq(['no-reply+test@tedxultimo.com'])}

    describe "#body" do
      subject{mail.body.encoded}
      it{should match('OMG, the target date for the following action')}
    end
  end

end
