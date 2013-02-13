class TalksController < ApplicationController
  inherit_resources

  belongs_to :event, optional: true

  respond_to :json
end
