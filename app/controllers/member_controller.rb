class MemberController < ApplicationController
  authorize_resource

  respond_to :json

	#TODO: implement when the actions will get associated to users
end