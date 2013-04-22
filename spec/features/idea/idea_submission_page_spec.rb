require_relative '../collapsible_shared_examples'

describe "Idea submission page", js: true, acceptance: true do
  
  let(:talk) { Talk.find(1) }

  def submission_dialog
    page.find("#new-idea-dialog")
  end

  def talks_section
    submission_dialog.find(".talks")
  end

  def actions_section
    submission_dialog.find(".actions")
  end

  def add_new_action_button
    page.find("#add-new-action")
  end

  def new_action_description_field
    page.find('#new-action-description')
  end

  def idea_description_field
    page.find('#description')
  end

  def add_action(name)
    fill_in 'new-action-description', with: name
    add_new_action_button.click
    actions_section.should have_selector(".description", text: name)
  end

  before :each do
    talk.should_not be_nil
    visit "#/events/1/talks/1"
    find("[text()='Submit a new idea']").click
  end

  context "talks section" do
    it "should have the right title" do
      talks_section.should have_selector(".header", text: 'Inspired by')
    end

    it "should have the inspiring talk's title" do
        talks_section.should have_content talk.title
    end
  end

  context "actions section" do
    def new_action_description_field_should_be_invalid
      page.should have_selector("#new-action-description.ng-invalid")
    end

    def new_action_description_field_should_be_valid
      page.should_not have_selector("#new-action-description.ng-invalid")
    end

    def add_new_action_button_should_be_disabled
      page.should have_selector("#add-new-action[disabled='disabled']")
    end

    def add_new_action_button_should_not_be_disabled
      page.should have_selector("#add-new-action")
      page.should_not have_selector("#add-new-action[disabled='disabled']")
    end

    it "should have the right title" do
      page.should have_selector(".header", text: 'Into these actions...')
    end

    it "should allow you to add new actions" do
      new_action_description_field.value.should be_empty
      new_action_description_field_should_be_invalid
      add_new_action_button_should_be_disabled

      fill_in 'new-action-description', with: 'eat fruit'
      new_action_description_field_should_be_valid
      add_new_action_button_should_not_be_disabled

      add_new_action_button.click

      actions_section.should have_selector(".description", text: 'eat fruit')
      new_action_description_field.value.should be_empty
    end

    it "should not add an empty action on click" do
      new_action_description_field.value.should be_empty
      new_action_description_field_should_be_invalid
      add_new_action_button_should_be_disabled

      add_new_action_button.click
      new_action_description_field_should_be_invalid

      actions_section.should_not have_selector(".description", text: '')
    end

    it "should not add an empty action on submit" do
      new_action_description_field.value.should be_empty
      new_action_description_field_should_be_invalid
      add_new_action_button_should_be_disabled

      page.evaluate_script("$('#new-action-description').submit();")

      new_action_description_field_should_be_invalid

      actions_section.should_not have_selector(".description", text: '')
    end

    context "when actions exist" do
      before do
        add_action 'eat fruit'
      end

      def action_item
        actions_section.find(".description", text: 'eat fruit')
      end

      it "should allow you to remove actions" do
        action_item.should have_selector(".remove-button")
        action_item.find(".remove-button").click

        actions_section.should_not have_selector(".description", text: 'eat fruit')
      end
    end

  end

  context "submit idea button" do

    context "when idea has text" do

      before do
        fill_in "description", with: 'idea content'
      end

      context "when actions were added" do
        before do
          add_action('eat fruit')
        end

        it "should be enabled" do
          submission_dialog.should have_selector("#submit-idea")
          submission_dialog.should_not have_selector("#submit-idea[disabled='disabled']")
        end

        context "when clicked" do

          before do
            submission_dialog.find("#submit-idea").click
          end

          it "should redirect to the new idea's page" do
            page.should have_selector '#idea', visible: true
            page.should have_selector 'p.description', text: 'idea content'

            page.current_url.should include "/ideas/"
          end
        end
      end

      context "when no actions were added" do
        it "should be disabled" do
          submission_dialog.should have_selector("#submit-idea[disabled='disabled']")
        end
      end
    end

    context "when the idea has no text" do

        it "should be disabled" do
          submission_dialog.should have_selector("#submit-idea[disabled='disabled']")
        end

    end
  end

  context "when user clicks the cancel button" do
    def cancel_button
      submission_dialog.find('#cancel-button')
    end

    before :each do
      cancel_button.click
    end

    context "the confirmation dialog box" do
      def cancel_confirmation_dialog_box
        submission_dialog.find('#cancel-confirm-dialog')
      end

      def confirm_button
        cancel_confirmation_dialog_box.find('#confirm-button')
      end

      def close_button
        cancel_confirmation_dialog_box.find("#close-button")
      end

      it "should be displayed" do
        submission_dialog.should have_selector('#cancel-confirm-dialog', visible: true)
      end

      it "when user clicks the close button, it should close the dialog box" do
        close_button.click
        submission_dialog.should have_selector('#cancel-confirm-dialog', visible: false)
      end

      it "when the user clicks the confirm button, it should close the dialog box and navigate back to the originating page" do
        page.should have_selector("#new-idea-dialog", visible: true)
        confirm_button.click
        page.should have_selector("#new-idea-dialog", visible: false)
      end
    end

  end
end