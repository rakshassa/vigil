class Encounter < ApplicationRecord
    include FlagShihTzu # https://github.com/pboling/flag_shih_tzu
    # add new flags here (up to 64)
    has_flags 1 => :avoided_old_man,
              2 => :killed_old_man,
              :column => "skip_on_flags"

    has_flags 1 => :has_avoided_old_man,
              2 => :has_killed_old_man,
              :column => "flags_required"

    has_many :fights

    scope :not_skipped, ->(player_flags) { where("(skip_on_flags::bit(64) & ?::bit(64)) = B'0'::int::bit(64)", player_flags) }
    scope :skipped, ->(player_flags) { where("(skip_on_flags::bit(64) & ?::bit(64)) > B'0'::int::bit(64)", player_flags) }

    scope :has_all_required, ->(player_flags) { where("(flags_required::bit(64) & ?::bit(64)) = flags_required::bit(64)", player_flags) }

    def get_choice(choice_number)
        return choice_1 if choice_number == 1
        return choice_2 if choice_number == 2
        return choice_3 if choice_number == 3

        Rails.logger.info "Invalid Choice_Number: #{choice_number} of type: #{choice_number.class.name}"
        nil
    end
end
