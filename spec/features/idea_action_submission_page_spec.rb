describe "Action submission page", js: true, acceptance: true do
  let(:idea) { Idea.find(1) }

  before :each do
    ApplicationController.any_instance.stub(:current_member).and_return(Member.first)
    visit "/#/ideas/1"
    page.first(".content-header").click
    find("[text()='Suggest an action']").click
  end

  context "page text" do
    it "should display a header" do
      page.should have_content("Suggest")
    end
  end

  context "submit action button" do
    describe "when description has text and the target date is set" do
      before :each do
        find('#idea-action-edit .content-item textarea').set('action content')

        # set the date to the 15th of next month
        page.execute_script %Q{ $('[datepicker="datepicker"]').trigger("focus") }
        page.execute_script %Q{ $('a.ui-datepicker-next').trigger("click") }
        page.execute_script %Q{ $("a.ui-state-default:contains('15')").trigger("click") }
      end

      it "should be enabled" do
        page.should have_selector("#submit-idea-action")
        page.should_not have_selector("#submit-idea-action[disabled='disabled']")
      end

      describe "when clicked" do
        before :each do
          page.find("#submit-idea-action").click
        end

        it "should redirect to the new idea's page" do
          page.should have_selector '#idea', visible: true
          page.current_url.should include "/ideas/"
        end
      end
    end

    describe "when description doesn't have text and target date is not set" do
      it "should be disabled" do
        page.should have_selector("#submit-idea-action[disabled='disabled']")
      end
    end

    describe 'when description is set but target date is not' do
      it 'should be disabled' do
        find('#idea-action-edit .content-item textarea').set('action content')
        page.should have_selector("#submit-idea-action[disabled='disabled']")
      end
    end

    describe 'when target date is set but description is not' do
      it 'should be disabled' do
        # set the date to the 15th of next month
        page.execute_script %Q{ $('[datepicker="datepicker"]').trigger("focus") }
        page.execute_script %Q{ $('a.ui-datepicker-next').trigger("click") }
        page.execute_script %Q{ $("a.ui-state-default:contains('15')").trigger("click") }

        page.should have_selector("#submit-idea-action[disabled='disabled']")
      end
    end
  end

  context "when user clicks the cancel button" do

    before :each do
      find('#cancel-button').click
    end

    context "the confirmation dialog box" do
      it "should be displayed" do
        page.should have_selector('#cancel-confirm-dialog', visible: true)
      end

      it "when user clicks the close button, it should close the dialog box" do
        find("#close-button").click
        page.should have_selector('#cancel-confirm-dialog', visible: false)
      end

      it "when the user clicks the confirm button, it should close the dialog box and navigate back to the originating page" do
        page.should have_selector("#new-idea-action-dialog", visible: true)
        find('#confirm-button').click
        page.should have_selector("#new-idea-action-dialog", visible: false)
      end
    end
  end

end
