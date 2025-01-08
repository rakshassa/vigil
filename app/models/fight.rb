class Fight < ApplicationRecord
  belongs_to :player, optional: false
  belongs_to :monster, optional: true
  belongs_to :encounter, optional: true
end
