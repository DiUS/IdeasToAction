require 'spec_helper'

describe Member do
<<<<<<< HEAD
  it { should have_many(:idea_actions) }

  describe "credentials" do
    subject{Member.first}

    before(:each) do
      activate_authlogic
    end

    it "should allow blank usernames and passwords" do
      subject.username = ""
      subject.password = ""
      subject.valid?.should be_true
    end
  end

  describe ".usernames" do
    subject{Member.usernames}

    specify "that it returns an Array" do
      expect(subject.class).to eq Array
    end
    
    specify "that each username has two elements" do
      subject.each do |username|
        expect(username.size).to eq 2
      end
    end

    specify "that each username has a String as the first element" do
      subject.each do |username|
        expect(username.first.class).to eq String
      end
    end

    specify "that each username has a Fixum as the second element" do
      subject.each do |username|
        expect(username.last.class).to eq Fixnum
      end
    end

    specify "that one of the usernames is content_admin" do
      matching_username = subject.select{|username| username.first =~ /content_admin/}
      expect(matching_username).not_to be_empty
    end

    specify "that one of the usernames is global_admin" do
      matching_username = subject.select{|username| username.first =~ /global_admin/}
      expect(matching_username).not_to be_empty
    end
  end

  describe ".with_remindable_actions" do

  end

  describe "#remindable_actions" do
    let(:member){Member.find_by_persistence_token("1234")}
    subject{member.remindable_actions}

    describe "not found when today's date is longer than week prior to the target date" do
      before do
        Timecop.freeze(Time.local(1900))
      end

      after do
        Timecop.return
      end

      it "should have no remindable actions" do
        expect(subject).to be_empty
      end
    end

    describe "found when the date is within a week from the target date" do
      before do
        Timecop.freeze(member.idea_actions.first.target_date - 3.days)
      end

      after do
        Timecop.return
      end

      it "should have at least one remindable action" do
        expect(subject).to be_present
      end
    end
  end

  describe "#content_admin?" do

  end

  describe "#global_admin?" do

  end

  describe "#remindable?" do

  end

end
=======
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
>>>>>>> 013e4a013476aa652fbfe146dc0ecd2050e6a8a0
