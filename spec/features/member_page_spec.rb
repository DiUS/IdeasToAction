require_relative 'collapsible_shared_examples'

describe "Member page", js: true, acceptance: true do
  self.use_transactional_fixtures = false

  before do
    visit "#/member"
  end

  # it "should have a list of actions" do
  #   expect(page).to have_selector()
  # end

end
