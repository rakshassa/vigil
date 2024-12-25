class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def roll_variance(base_number, variance)
    lower = (base_number * (1-variance)).floor
    upper = (base_number * (1+variance)).ceil
    Rands.rand(lower, upper)
  end

  # returns boolean: success
  def roll_chance(success_percentage)
    chance = Rands.rand(1, 100)
    chance < success_percentage
  end
end
