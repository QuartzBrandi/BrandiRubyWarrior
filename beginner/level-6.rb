
class Player

  def play_turn(warrior)
    @warrior = warrior
    health?

    direction = :forward
    unless covered_the_rear?
      direction = :backward
    end

    action(direction)

    @health = @warrior.health
  end

  def health?
    @health = 20 if @health.nil?
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

  def covered_the_rear?
    if @rear_covered
      true
    elsif @warrior.feel(:backward).wall?
      @rear_covered = true
      true
    elsif @warrior.feel(:backward).empty?
      false
    elsif @warrior.feel(:backward).captive?
      false
    elsif !@warrior.feel(:backward).enemy?
      false
    else
      false
    end
  end

  def action(direction)
     if taking_damage?
        taking_damage_action
      elsif @warrior.feel(direction).stairs?
        @warrior.walk!(direction)
      elsif @warrior.feel(direction).empty? && @warrior.health < 20
        @warrior.rest!
      elsif @warrior.feel(direction).enemy?
        @warrior.attack!(direction)
      elsif @warrior.feel(direction).captive?
        @warrior.rescue!(direction)
      elsif @warrior.feel(direction).empty?
        @warrior.walk!(direction)
      end
  end
end
