require 'pathname'

class WelcomeController < ApplicationController
  include ApplicationHelper

  def index
    case Rails.env
      when 'development', 'test'
        render 'app/assets/templates/index', :formats => [:html]
      else
        render :file => 'public/assets/index.html', :formats => [:html]
    end
  end
end 
