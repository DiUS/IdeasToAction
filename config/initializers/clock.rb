require_relative '../environment'

module Clockwork
  every(1.day, 'Mailer.reminders', at: '00:00') do
    Mailer.delay.reminders
  end
end
