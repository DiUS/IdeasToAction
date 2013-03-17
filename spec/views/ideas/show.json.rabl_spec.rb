require 'spec_helper'

describe 'harbors/index.json.rabl' do
  before :each do
    @idea = Idea.first
    @idea.idea_actions = [] # having idea actions causes association errors in spec, might need further investigation
    @rendered = Rabl.render(@idea, 'ideas/show', :view_path => 'app/views')
  end

  it 'includes all idea attributes' do
    attributes = @idea.to_hash.to_json # first converting to hash to bypass 'to_json' method on the model itself
    @rendered.should be_json_eql(attributes).excluding(:members_actioned_count, :tags, :idea_actions, :reactions, :talks)
  end

  it "includes member actioned count" do
    @rendered.should have_json_path("members_actioned_count")
    @rendered.should have_json_type(Integer).at_path("members_actioned_count")
  end

  it "includes the collection of tags" do
    @rendered.should have_json_path("tags")
    @rendered.should have_json_type(Array).at_path("tags")
  end

  it "includes the collection of idea actions" do
    @rendered.should have_json_path("idea_actions")
    @rendered.should have_json_type(Array).at_path("idea_actions")
  end

  it "includes the collection of talks" do
    @rendered.should have_json_path("talks")
    @rendered.should have_json_type(Array).at_path("talks")
  end

  it "includes the collection of reactions" do
    @rendered.should have_json_path("reactions")
    @rendered.should have_json_type(Array).at_path("reactions")
  end
end
