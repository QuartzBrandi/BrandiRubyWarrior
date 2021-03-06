
class Player

  MAX_HEALTH = 20
  LOW_HEALTH = 10

  def initialize
    @health = MAX_HEALTH
  end

  def play_turn(warrior)
    @warrior = warrior

    action

    @health = @warrior.health
  end

  # ALL THE ACTIONS YOU CAN TAKE
  def action
    if taking_damage?
      taking_damage_action
    elsif @warrior.feel.stairs?
      @warrior.walk!
    elsif @warrior.feel.empty? && below_max_health?
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

  # CHECKS TO SEE IF THE HERO IS CURRENTLY TAKING DAMAGE
  def taking_damage?
    if @warrior.health < @health
      true
    else
      false
    end
  end

  # CHECKS TO SEE IF HERO IS BELOW MAX HEALTH
  def below_max_health?
    @warrior.health < MAX_HEALTH
  end

  # CHECKS TO SEE IF HERO HAS LOW HEALTH
  def low_health?
    @health < LOW_HEALTH
  end

  # ACTIONS FOR IF THE HERO IS TAKING DAMAGE
  def taking_damage_action
    if @warrior.feel(:backward).empty? && low_health?
      @warrior.walk!(:backward)
    elsif @warrior.feel.empty?
      @warrior.walk!
    elsif @warrior.feel.enemy?
      @warrior.attack!
    end
  end

end
