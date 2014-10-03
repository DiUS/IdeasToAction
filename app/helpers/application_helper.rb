module ApplicationHelper

  def env_has_analytics?
    !!Rails.application.config.analytics_tracking_key
  end

end
