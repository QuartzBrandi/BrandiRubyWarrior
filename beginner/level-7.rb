
class Player

  MAX_HEALTH = 20

  def play_turn(warrior)
    @warrior = warrior
    nil_check

    action

    @health = @warrior.health
  end

  # ASSIGNS INSTANCE VARIABLES WHEN YOU FIRST START
  def nil_check
    @health ||= MAX_HEALTH
    @direction ||= :left
    @left_covered ||= 0
    @right_covered ||= 0
  end

  # ALL THE ACTIONS YOU CAN TAKE
  def action
    if taking_damage?
      taking_damage_action
    elsif @warrior.feel.stairs?
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

  # CHECKS TO SEE IF THE HERO IS CURRENTLY TAKING DAMAGE
  def taking_damage?
    if @warrior.health < @health
      true
    else
      false
    end
  end

  # ACTIONS FOR IF THE HERO IS TAKING DAMAGE
  def taking_damage_action
    if @warrior.feel(:backward).empty? && @health < 10
      @warrior.walk!(:backward)
    elsif @warrior.feel.empty?
      @warrior.walk!
    elsif @warrior.feel.enemy?
      @warrior.attack!
    end
  end

end
