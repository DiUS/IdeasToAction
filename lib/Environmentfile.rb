class Environmentfile

  class << self

    def read
      File.read(Rails.root.join('Environmentfile'))
    end

    def load
      instance_eval(read)
    end

  end # class << self

end
