class MemberController < ApplicationController
  authorize_resource

  respond_to :json

	def idea_actions
		render json: current_member.idea_actions.uncompleted_first.map{|a| a.attributes.merge(completable: a.completable?(current_member))}
	end
end