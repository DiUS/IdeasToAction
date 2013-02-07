class HeartbeatController < ApplicationController
  def beat
    @heartbeat =
      {
        member_id: member.id
      }

   respond_to do |format|
      format.html 
      format.json { render json: @heartbeat }
    end    
  end
end
