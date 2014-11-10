class Cell < ActiveRecord::Base
  SATIETY_REQUIRED_TO_MOVE = 2
  MAXIMUM_SATIETY = 10

  validates :x, :y, :satiety, :propensity_to_move, :propensity_to_reproduce, presence: true
  validates :propensity_to_reproduce, :propensity_to_move, inclusion: { in: 0..100 }
  validates :satiety, inclusion: { in: 0..MAXIMUM_SATIETY }
  validates :x, uniqueness: { scope: :y }



  def attempt_to_reproduce(available_mates, available_birth_places)
    if wants_to_reproduce? && available_mates.length > 0 && available_birth_places.length > 0
       return CreateOffspring.new(self, available_mates.sample, available_birth_places.sample).make!
    end
  end

  def attempt_to_move(occupiable_neighbouring_squares, world)
    if wants_to_move? && occupiable_neighbouring_squares.length > 0
      MoveCell.new(self, occupiable_neighbouring_squares.sample, world).move
    end
  end

  def mate
    self.has_mated = true
  end

  def wants_to_reproduce?
    random_number = [*0..100].sample
    random_number <= propensity_to_reproduce && !has_mated 
  end

  private

  def wants_to_move?
    random_number = [*0..100].sample
    random_number <= propensity_to_reproduce && satiety >= SATIETY_REQUIRED_TO_MOVE
  end
end