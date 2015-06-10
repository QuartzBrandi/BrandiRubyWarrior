
class Player

  MAX_HEALTH = 20

  def play_turn(warrior)
    @warrior = warrior
    nil_check

    ground_covered?
    change_direction
  end

  def nil_check
    @health = MAX_HEALTH if @health.nil?
    @direction = :left if @direction.nil?
    @left_covered = 0 if @left_covered.nil?
    @right_covered = 0 if @right_covered.nil?
    # may need to add a pivot :left here as well
  end

  def action
    if taking_damage?
      taking_damage_action
    elsif @warrior.feel.stairs? && ground_covered?
      @warrior.walk!
    elsif @warrior.feel.empty? && @warrior.health < 20
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
    if @warrior.feel.empty? && @health < 10
      @warrior.walk!(:backward)
    elsif @warrior.feel.empty?
      @warrior.walk!
    elsif @warrior.feel.enemy?
      @warrior.attack!
    end
  end

  # def set_direction(direction)
  #   @direction = direction
  # end

  def change_direction
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

  # TESTS AND ASSIGNS IF HERO REACHED A WALL
  def ground_covered?
    if @direction == :left
      @left_covered = direction_covered?(@left_covered)
    elsif @direction == :right
      @right_covered = direction_covered?(@right_covered)
    end

    if (@left_covered == (1 || -1)) && (@right_covered == (1 || -1))
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
