class WelcomeController < ApplicationController
  def index
    redirect_to '/assets/index.html'
  end
end
