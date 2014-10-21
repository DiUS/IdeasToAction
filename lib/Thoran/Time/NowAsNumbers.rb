# Thoran/Time/NowAsNumbers.rb
# Thoran::Time::NowAsNumbers#now_as_numbers

# 20141021
# 0.0.2

# Description: This replaces any non-numeric character in Time.now.to_s.

# Discussion:
# 1. I wasn't sure if I wanted to include the time zone, since that isn't part of the time locally anyway,
# but then thought that if this method of uniquely identifying when an event occurs is used by multiple processes
# on different parts of the globe over a 24 hour period then a clash albeit unlikely is possible.
# 2. I'm also hoping that it isn't too long for the currently intended purpose which is as a fallback number for
# a build number where that build number isn't specified.
# 3. Time.now.to_i was no good as it doesn't include the time zone and as per the discussion above, it would not
# be adequate for that reason.

module Thoran
  module Time
    module NowAsNumbers

      def now_as_numbers
        ::Time.now.to_s.gsub(/\D/, '')
      end

    end
  end
end

Time.extend(Thoran::Time::NowAsNumbers)
