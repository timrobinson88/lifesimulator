class Cell < ActiveRecord::Base
  include BaseCell
  SATIETY_REQUIRED_TO_MOVE = 2
  MAXIMUM_SATIETY = 10
  COLOUR_MAP = {
    10 => "#10B600",
    9 => "#3DE800",
    8 => "#B0FF00",
    7 => "#E8E100",
    6 => "#FFD800",
    5 => "#B67D00",
    4 => "#E88600",
    3 => "#FF6B00",
    2 => "#E83A00",
    1 => "#FF1000"
  }

  validates :x, :y, :satiety, :propensity_to_move, :propensity_to_reproduce, presence: true
  validates :propensity_to_reproduce, :propensity_to_move, inclusion: { in: 0..100 }
  validates :satiety, inclusion: { in: 0..MAXIMUM_SATIETY }
  validates :x, uniqueness: { scope: :y }

  def colour
    COLOUR_MAP[satiety]
  end

  def able_to_reproduce?
    random_number = [*0..100].sample
    random_number <= propensity_to_reproduce && !has_mated 
  end

  def can_be_saved?
    true
  end

  def able_to_move?
    random_number = [*0..100].sample
    random_number <= propensity_to_reproduce
  end
end