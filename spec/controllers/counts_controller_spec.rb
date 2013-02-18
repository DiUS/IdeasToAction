require 'spec_helper'

describe CountsController do

  describe "GET index" do
    before do
      Member.should_receive(:count).and_return(5)
      Idea.should_receive(:count).and_return(6)
      Action.should_receive(:count).and_return(7)
    end

    it "returns counts for member, idea and actions taken" do
      get :index
      response.body.should == { :members => 5, :ideas => 6, :actions => 7 }.to_json
    end
  end
end