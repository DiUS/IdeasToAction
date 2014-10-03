# Thoran/String/Captures/captures.rb
# Thoran::String::Captures#captures

# 20141003
# 0.2.0

# Changes:
# 1. + Captures namespace.

module Thoran
  module String
    module Captures

      def captures(regex)
        if md = self.match(regex)
          md.captures
        else
          nil
        end
      end

    end
  end
end

String.send(:include, Thoran::String::Captures)
