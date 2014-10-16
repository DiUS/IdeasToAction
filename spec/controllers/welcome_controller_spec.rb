require 'spec_helper'

describe WelcomeController do

  describe "GET index" do

    before do
      get :index
    end

    it "should be successful" do
      expect(response).to be_success
    end

    it "renders the index layout" do
      expect(controller).to render_template(Rails.root.join('app', 'assets', 'templates', 'index'))
    end
  end

end
