class Road < ApplicationRecord
  belongs_to :monster, optional: true
  belongs_to :encounter, optional: true
  belongs_to :player
end
