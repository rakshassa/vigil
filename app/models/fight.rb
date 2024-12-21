class Fight < ApplicationRecord
  belongs_to :player
  belongs_to :monster
end
