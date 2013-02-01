require 'spec_helper'

describe Talk do
  
  it { should have_many(:ideas).through(:talk_to_idea_associations) }

end
