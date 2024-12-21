class Rands
    @@gen = Random.new

    def self.rand(min, max)
        @@gen.rand(min..max)
    end
end
