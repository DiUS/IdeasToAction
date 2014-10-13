# Thoran/Array/Frequencies/frequencies.rb
# Thoran::Array::Frequencies#frequencies

# 20141013
# 0.1.0

# Description: Returns a hash with the element as the key and the count of those elements.  

# Changes:
# 1. + Thoran namespace.

module Thoran
  module Array
    module Frequencies

      def frequencies
        self.each_with_object(Hash.new(0)) do |e,m|
          m[e] += 1
        end
      end

    end
  end
end

Array.send(:include, Thoran::Array::Frequencies)

if __FILE__ == $0
  puts [:a, :b, :b, :c, :c, :c].frequencies == {a: 1, b: 2, c: 3} ? '.' : 'x'
end
