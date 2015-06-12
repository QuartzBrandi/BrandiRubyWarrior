class Player
  attr_reader :warrior

  DIRECTIONS = [:forward, :backward, :left, :right]

  def play_turn(warrior_obj)
    @warrior = warrior_obj

    action, direction = actions
    warrior.send(action, direction)
  end

  # RETURNS A 'SPACE' OBJECT IN SPECIFIED DIRECTION
  def space(direction)
    warrior.feel(direction)
  end

  # RETURNS :forward :backward :left :right ACCORDING TO THE DIRECTION OF THE STAIRS
  def stairs
    warrior.direction_of_stairs
  end

  # RETURNS AN ACTION AMONG ALL THE ACTIONS WARRIOR CAN (/SHOULD) TAKE
  def actions
    action = [:walk!, stairs]
    action = [:attack!, direction_of_x(:enemy?)] if is_x_nearby?(:enemy?)

    return action
  end

  # RETURNS TRUE OR FALSE IF OBJECT SPECIFIED IS ONCE SPACE AWAY
  def is_x_nearby?(search_for) # 'search_for' should be a symbol of a 'space' method (empty? enemy? captive? etc.)
    occupied = false
    DIRECTIONS.each do |direction|
      occupied = true if space(direction).send(search_for)
    end
    return occupied
  end

  # RETURNS FIRST OCCURING DIRECTION OF OBJECT SPECIFIED
  def direction_of_x(search_for) # 'search_for' should be a symbol of a 'space' method (empty? enemy? captive? etc.)
    DIRECTIONS.each do |direction|
      return direction if object_in_direction?(direction, search_for)
    end
  end

  # RETURNS TRUE IF SPECIFIED OBJECT IS IN SPECIFIED DIRECTION ELSE FALSE
  def object_in_direction?(direction, search_for)
    space(direction).send(search_for)
  end

end
