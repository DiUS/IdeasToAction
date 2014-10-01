require 'clockwork'
require 'config/boot'
require 'config/environment'

module Clockwork
  every(1.day, 'remind', at: '00:00') do
    Mailer.delay.remind
  end
end
