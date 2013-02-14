require_relative 'collapsible_shared_examples'

describe "Idea submission page", js: true, acceptance: true do
  
  let(:talk) { Talk.find(1) }

  def talks_section
    page.find(".talks")
  end

  def actions_section
    page.find(".actions")
  end

  before :each do
    talk.should_not be_nil
    visit "/assets/index.html#/events/1/talks/1"
    page.find('#new-idea', text: 'Submit a new idea').click
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
    def add_new_action_button
      actions_section.find("#add-new-action")
    end

    def action_items_container
      actions_section.find('.items')
    end

    def new_action_description_field
      actions_section.find('#new-action-description')
    end

    def new_action_description_field_should_be_invalid
      actions_section.should have_selector("#new-action-description.ng-invalid")
    end

    def new_action_description_field_should_be_valid
      actions_section.should_not have_selector("#new-action-description.ng-invalid")
    end

    def add_new_action_button_should_be_disabled
      actions_section.should have_selector("#add-new-action[disabled='disabled']")
    end

    def add_new_action_button_should_not_be_disabled
      actions_section.should have_selector("#add-new-action")
      actions_section.should_not have_selector("#add-new-action[disabled='disabled']")
    end

    it "should have the right title" do
      actions_section.should have_selector(".header", text: 'Into these actions...')
    end

    it "should allow you to add new actions" do
      new_action_description_field.value.should be_empty
      new_action_description_field_should_be_invalid
      add_new_action_button_should_be_disabled

      fill_in 'new-action-description', with: 'eat fruit'
      new_action_description_field_should_be_valid
      add_new_action_button_should_not_be_disabled

      add_new_action_button.click

      action_items_container.should have_selector(".item", text: 'eat fruit')
      new_action_description_field.value.should be_empty
    end

    it "should not add an empty action on click" do
      new_action_description_field.value.should be_empty
      new_action_description_field_should_be_invalid
      add_new_action_button_should_be_disabled

      add_new_action_button.click
      new_action_description_field_should_be_invalid

      action_items_container.should_not have_selector(".item p", text: '')
    end

    it "should not add an empty action on submit" do
      new_action_description_field.value.should be_empty
      new_action_description_field_should_be_invalid
      add_new_action_button_should_be_disabled

      page.evaluate_script("$('#new-action-description').submit();")

      new_action_description_field_should_be_invalid

      action_items_container.should_not have_selector(".item p", text: '')
    end

    context "when actions exist" do
      before do
        fill_in 'new-action-description', with: 'eat fruit'
        add_new_action_button.click
        action_items_container.should have_selector(".item", text: 'eat fruit')
      end

      def action_item
        action_items_container.find(".item", text: 'eat fruit')
      end

      it "should allow you to remove actions" do
        action_item.should have_selector(".remove-button")
        action_item.find(".remove-button").click

        action_items_container.should_not have_selector(".item", text: 'eat fruit')
      end
    end

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