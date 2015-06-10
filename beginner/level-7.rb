
class Player

  MAX_HEALTH = 20

  def play_turn(warrior)
    @warrior = warrior
    nil_check

    check_direction
    action_extended

    @health = @warrior.health
  end

  def nil_check
    @health ||= MAX_HEALTH
    @direction ||= :left
    @left_covered ||= 0
    @right_covered ||= 0
    # may need to add a pivot :left here as well
  end

  def action
    if taking_damage?
      taking_damage_action
    elsif @warrior.feel.stairs? && ground_covered?
      @warrior.walk!
    elsif @warrior.feel.empty? && @warrior.health < MAX_HEALTH
      @warrior.rest!
    elsif @warrior.feel.enemy?
      @warrior.attack!
    elsif @warrior.feel.captive?
      @warrior.rescue!
    elsif @warrior.feel.empty?
      @warrior.walk!
    elsif @warrior.feel.wall?
      @warrior.pivot!(:backward)
    end
  end

  def taking_damage?
    if @warrior.health < @health
      true
    else
      false
    end
  end

  def taking_damage_action
    if @warrior.feel(:backward).empty? && @health < 10
      @warrior.walk!(:backward)
    elsif @warrior.feel.empty?
      @warrior.walk!
    elsif @warrior.feel.enemy?
      @warrior.attack!
    end
  end

  def action_extended
    if @left_covered == 0 || @right_covered == 0
      action
    elsif @left_covered == -1 && @direction != :left
      set_direction(:left)
      @warrior.pivot!(:left)
    elsif @right_covered == -1 && @direction != :right
      set_direction(:right)
      @warrior.pivot!(:right)
    end
  end

  def set_direction(direction)
    @direction = direction
  end

  # TESTS IF HERO REACHED A WALL
  def check_direction
    if @direction == :left
      @left_covered = direction_covered?(@left_covered)
    elsif @direction == :right
      @right_covered = direction_covered?(@right_covered)
    end
  end

  # TESTS IF ALL GROUND HAS BEEN COVERED
  def ground_covered?
    if (@left_covered == 1 || @left_covered == -1) && (@right_covered == 1 || @right_covered == -1)
      return true
    else
      return false
    end
  end

  # RETURNS 1 FOR TRUE; 0 FOR FALSE; -1 FOR TRUE + STAIRS
  def direction_covered?(direction_covered)
    if direction_covered == 1
      1  # true
    elsif direction_covered == -1
      -1  # true, but note the prescence of stairs
    elsif @warrior.feel.wall?
      1  # true
    elsif @warrior.feel.stairs?
      -1  # true, but note the presence of stairs
    elsif @warrior.feel.empty?
      0  # false
    elsif @warrior.feel.captive?
      0  # false
    elsif @warrior.feel.enemy?
      0  # false
    else
      0  # false
    end
  end

end
