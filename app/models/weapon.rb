class Weapon < ApplicationRecord
    has_many :players, dependent: :destroy
end
