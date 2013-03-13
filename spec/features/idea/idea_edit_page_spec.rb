describe "Idea edit page", js: true, acceptance: true do
  
  let(:idea) { Idea.first }
  let(:content_admin) { Member.find_by_role(Member::ROLE_CONTENT_ADMIN) }

  before do
    Capybara.reset_sessions!
    login(content_admin)
    idea.should_not be_nil
    visit "#/ideas/edit/#{idea.id}"
  end

  it "should have the form to edit the idea" do
    page.should have_selector '#description'
    page.should have_selector '#featured'
  end

  it 'should have the fields pre-populated with the idea details' do
    page.find('#description').value.should eql idea.description
    page.find('#featured').checked?.should eql idea.featured
  end

  it 'should be able to change the details of the idea' do
    time = Time.now
    fill_in 'description', with: "changed on: #{time}"
    page.find('button[ng-click="update()"]').click
    visit "#/ideas/edit/#{idea.id}"
    page.find('#description').value.should eql "changed on: #{time}"
  end

  # context "Actions collapsible" do
  #   let(:title) { "Actions" }
  #   let(:item_contents) { idea.actions.map(&:description) }

  #   it_should_behave_like "a collapsible"

  #   xit 'should link to an edit action page' do
  #     first = page.find(".collapsible[title='#{title}']").find('.item:first .description')
  #     first['ng-href'].should eql "/actions/edit/#{idea.actions.first.id}"
  #   end
  # end
end