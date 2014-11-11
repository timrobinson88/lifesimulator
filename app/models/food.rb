class Food < ActiveRecord::Base
  CHANCE_OF_REPLENISHMENT = 15

  validates :x, uniqueness: { scope: :y }
end
