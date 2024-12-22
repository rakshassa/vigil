class Rands
    @@gen = Random.new

    def self.rand(min, max)
        Rails.logger.info("Random Instance: #{@@gen}")
        @@gen.rand(min..max)
    end
end
