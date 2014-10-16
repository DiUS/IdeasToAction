class MembersController < ApplicationController
	inherit_resources
	authorize_resource

	respond_to :json
end