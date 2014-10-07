module ApplicationHelper

  def env_has_analytics?
    Rails.application.config.respond_to?(:analytics_tracking_key) &&
      !!Rails.application.config.analytics_tracking_key
  end

end
