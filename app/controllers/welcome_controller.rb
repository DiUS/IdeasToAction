class WelcomeController < ApplicationController
  def index
    render 'app/assets/templates/index', :formats => [:html]
  end
end
