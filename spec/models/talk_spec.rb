require 'spec_helper'

describe Talk do

  it { should be_accessible(:description) }
  it { should be_accessible(:title) }
  it { should be_accessible(:ideas) }
  it { should be_accessible(:hero_image_url) }
  it { should be_accessible(:ted_talk_url) }
  it { should be_accessible(:featured) }
  it { should be_accessible(:event_id ) }

  it { should delegate(:name).to(:event).with_prefix }
  it { should have_many(:ideas).through(:talk_to_idea_associations) }

end
