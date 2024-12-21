class Armor < ApplicationRecord
    has_many :players, dependent: :destroy
end
