# Thoran/File/SelfFilenameWithoutExtname/self.basename_without_extname.rb
# Thoran::File::SelfFilenameWithoutExtname.basename_without_extname.rb

# 20141003
# 0.2.0

# Description: This returns the basename without the extension for a given File instance without the need to specify what the extension is because it makes use of File.extname which works that out.

# Changes:
# 1. + Thoran::File::SelfFilenameWithoutExtname namespace.

module Thoran
  module File
    module SelfFilenameWithoutExtname

      def basename_without_extname(path)
        basename(path, extname(path))
      end

    end
  end
end

File.extend(Thoran::File::SelfFilenameWithoutExtname)
