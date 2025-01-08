# TODO: better storage for named_bits
# need a good way to set/unset a bit AND check a bit
class Flags
    def initialize
        @flags = 0
    end

    def self.AvoidOldMan
        0b00000001
    end

    # https://www.honeybadger.io/blog/ruby-bitwise-operators/
    def set_flag(flag_bit)
        @flags = @flags | flag_bit
    end

    def clear_flag(flag_bit)
        @flags = @flags & (~flag_bit)
    end

    def is_set?(flag_bit)
        (@flags & flag_bit) > 0
    end
end
