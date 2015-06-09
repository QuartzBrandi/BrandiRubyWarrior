
class Player

  def play_turn(warrior)
    @warrior = warrior
    health?

    if taking_damage?
      taking_damage_action
    elsif @warrior.feel.empty? && @warrior.health < 20
      @warrior.rest!
    elsif @warrior.feel.enemy?
      @warrior.attack!
    elsif @warrior.feel.captive?  # ADDED FOR LEVEL 5
      @warrior.rescue!            # ADDED FOR LEVEL 5
    elsif @warrior.feel.empty?
      @warrior.walk!
    end

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
    if @warrior.feel.empty?
      @warrior.walk!
    elsif @warrior.feel.enemy?
      @warrior.attack!
    end
  end
end
