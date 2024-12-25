class Trinket < ApplicationRecord
    has_many :player_trinkets, dependent: :destroy
end
