require_relative 'collapsible_shared_examples'

describe "Idea submission page", js: true, acceptance: true do
  
  let(:talk) { Talk.find(1) }

  before :each do
    talk.should_not be_nil
    visit "/assets/index.html#/events/1/talks/1"
    page.find('#new-idea', text: 'Submit a new idea').click
  end

  context "Inspired by collapsible" do
    let(:title) { "Inspired by..." }
    let(:item_contents) { [ talk.title ] }

    let (:starts_as_collapsed?) { false }

    it_should_behave_like "a collapsible"
  end

  context "when user clicks the cancel button" do
    def cancel_button
      page.find('.cancel-button')
    end

    before :each do
      cancel_button.click
    end

    context "the confirmation dialog box" do
      def cancel_confirmation_dialog_box
        page.find('#cancel-confirm-dialog')
      end

      def confirm_button
        cancel_confirmation_dialog_box.find('#confirm-button')
      end

      def close_button
        cancel_confirmation_dialog_box.find("#close-button")
      end

      it "should be displayed" do
        page.should have_selector('#cancel-confirm-dialog', visible: true)
      end

      it "when user clicks the close button, it should close the dialog box" do
        close_button.click
        page.should have_selector('#cancel-confirm-dialog', visible: false)
      end

      it "when the user clicks the confirm button, it should close the dialog box and navigate back to the originating page" do
        confirm_button.click
        page.current_url.should include "/events/1/talks/1"
      end
    end

  end
end