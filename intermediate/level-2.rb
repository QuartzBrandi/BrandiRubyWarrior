class Player
  attr_reader :warrior, :starting_health, :ending_health

  DIRECTIONS = [:forward, :backward, :left, :right]
  MAX_HEALTH = 20

  def initialize
    @health = 20
  end

  def play_turn(warrior_obj)
    @warrior = warrior_obj
    @starting_health = warrior.health

    action

    @ending_health = warrior.health
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
    action = [:rest!] if starting_health < MAX_HEALTH
    action = [:attack!, direction_of_x(:enemy?)] if is_x_nearby?(:enemy?)

    return action
  end

  # CHECKS TO SEE IF ACTION REQUIRES ARGUMENTS & PERFORMS THE ACTION
  def action
    warrior_action, direction = actions

    if direction.nil?
      warrior.send(warrior_action)
    else
      warrior.send(warrior_action, direction)
    end
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
