class Player
  attr_reader :warrior, :current_direction

  DIRECTIONS = [:forward, :backward, :left, :right]

  def play_turn(warrior_obj)
    @warrior = warrior_obj
    @current_direction = :forward

    action, direction = actions
    warrior.send(action, direction)
  end

  def space(direction)
    warrior.feel(direction)
  end

  # RETURNS :forward :backward :left :right IN DIRECTION OF STAIRS
  def stairs
    warrior.direction_of_stairs
  end

  def actions
    hero_action = [:walk!, stairs]
    hero_action = [:attack!, direction_of_x(:enemy?)] if is_x_nearby?(:enemy?)

    return hero_action
  end

  # def action
  #   if is_x_nearby?(:enemy?)
  #     warrior.attack!(direction_of_x(:enemy?))
  #   end
  # end

  def is_x_nearby?(search_for) # NEEDS TO BE A SYMBOL AND A SPACE METHOD (empty? enemy? captive? etc.)
    occupied = false
    DIRECTIONS.each do |direction|
      occupied = true if space(direction).send(search_for)
    end
    return occupied
  end

  def direction_of_x(search_for) # RETURNS FIRST OCCURING DIRECTION OF OBJECT SEARCHING FOR
    DIRECTIONS.each do |direction|
      return direction if object_in_direction?(direction, search_for)
    end
  end

  def object_in_direction?(direction, search_for)
    space(direction).send(search_for)
  end

  def change_direction(direction)
    current_direction = direction
  end
end
