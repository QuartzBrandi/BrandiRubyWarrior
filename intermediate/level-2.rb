class Player
  attr_reader :warrior, :current_direction

  DIRECTIONS = [:forward, :backward, :left, :right]

  def play_turn(warrior_obj)
    @warrior = warrior_obj
    @current_direction = :forward

    warrior.send(action, where_stairs)
  end

  def space(direction)
    warrior.feel(direction)
  end

  # RETURNS :forward :backward :left :right IN DIRECTION OF STAIRS
  def where_stairs
    warrior.direction_of_stairs
  end

  def action
    hero_action = :walk!
    hero_action = :attack! if space(where_stairs).enemy?

    return hero_action
  end

  def x_nearby?(search_symbol)
    if space(:forward).send(search_symbol)
      direction(:forward)
      return true
    elsif space(:backward).send(search_symbol)
      direction(:backward)
      return true
    elsif space(:left).send(search_symbol)
      direction(:left)
      return true
    elsif space(:right).send(search_symbol)
      direction(:right)
      return true
    else
      return false
    end

    occupied = false

    DIRECTIONS.each do |direction|
      occupied = true if space(direction).send(search_symbol)
    end
  end

  def object_nearby?(object_symbol)

  end

  def object_in_direction?(direction, object_symbol)
    space(direction).send(object_symbol)
  end

  def x_backward?(search_symbol)
    space(:backward).send(search_symbol)
  end

  def change_direction(direct)
    current_direction = direct
  end
end
