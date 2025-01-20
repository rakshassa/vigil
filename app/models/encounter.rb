class Encounter < ApplicationRecord
    include FlagShihTzu # https://github.com/pboling/flag_shih_tzu
    # add new flags here (up to 64)
    has_flags 1 => :avoided_old_man,
              2 => :killed_old_man,
              3 => :lost_squirrel,
              4 => :freed_squirrels,
              5 => :obtained_ring_speed,
              6 => :grandma_scared,
              7 => :grandma_happy,
              8 => :burned_house,
              9 => :stephen_bucket,
              10 => :angry_stephen,
              11 => :squirrel,
              12 => :hamster,
              :column => "skip_on_flags"

    has_flags 1 => :has_avoided_old_man,
              2 => :has_killed_old_man,
              3 => :has_lost_squirrel,
              4 => :has_freed_squirrels,
              5 => :has_obtained_ring_speed,
              6 => :has_grandma_scared,
              7 => :has_grandma_happy,
              8 => :has_burned_house,
              9 => :has_stephen_bucket,
              10 => :has_angry_stephen,
              11 => :has_squirrel,
              12 => :has_hamster,
              :column => "flags_required"

    has_many :fights, dependent: :destroy
    has_many :roads, dependent: :destroy

    scope :not_skipped, ->(player_flags) { where("(skip_on_flags::bit(64) & ?::int::bit(64)) = B'0'::int::bit(64)", player_flags) }
    scope :skipped, ->(player_flags) { where("(skip_on_flags::bit(64) & ?::int::bit(64)) > B'0'::int::bit(64)", player_flags) }

    scope :has_all_required, ->(player_flags) { where("(flags_required::bit(64) & ?::int::bit(64)) = flags_required::bit(64)", player_flags) }

    def get_choice(choice_number)
        return choice_1 if choice_number == 1
        return choice_2 if choice_number == 2
        return choice_3 if choice_number == 3

        Rails.logger.info "Invalid Choice_Number: #{choice_number} of type: #{choice_number.class.name}"
        nil
    end
end
