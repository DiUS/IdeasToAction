class TalksController < ApplicationController
  inherit_resources

  belongs_to :event

  respond_to :json
end
