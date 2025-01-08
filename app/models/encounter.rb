class Encounter < ApplicationRecord
    has_many :fights

    def get_choice(choice_number)
        return choice_1 if choice_number == 1
        return choice_2 if choice_number == 2
        return choice_3 if choice_number == 3

        Rails.logger.info "Invalid Choice_Number: #{choice_number} of type: #{choice_number.class.name}"
        nil
    end
end
