module ApplicationHelper
  def env_has_analytics?
    CONFIG.keys.collect{|key| key.to_s}.each do |env_key|
      if env_key.casecmp(Rails.env) == 0 && CONFIG[env_key.to_sym].kind_of?(Hash) && CONFIG[env_key.to_sym][:analytics_tracking_key].present?
        return true
      end
    end
    false
  end
end
