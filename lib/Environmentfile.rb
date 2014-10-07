class Environmentfile

  class << self

    def read
      File.read(Rails.root.join('Environmentfile'))
    end

    def load
      instance_eval(read)
    end

    def parse
      envar_lines = read.split("\n").reject{|line| line =~/^#/}.reject{|line| line == ''}
      envar_lines.inject({}) do |envars, envar_line|
        envar, enval = envar_line.captures(/ENV\['(.+)'\].*=.*['"](.+)['"]/)
        envars[envar] = enval
        envars
      end
    end

    def [](envar)
      parse[envar]
    end

  end # class << self

end
