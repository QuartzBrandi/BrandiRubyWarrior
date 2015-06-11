# TOTALLY UNORGANIZED CODE, YEAH!
class Player
  attr_reader :warrior, :health

  MAX_HEALTH = 20
  LOW_HEALTH = 10

  def initialize
    @health = MAX_HEALTH
  end

  def play_turn(warrior)
    @warrior = warrior

    action

    @health = warrior.health
  end

  # SHORTCUT FOR WARRIOR.FEEL METHOD
  def space(direction=:forward)
    warrior.feel(direction)
  end

  # ALL THE ACTIONS YOU CAN TAKE
  def action
    if
      it_came_from_behind
    elsif taking_damage?
      taking_damage_action
    elsif captive_in_front?
      rescue_captive_action
    elsif space.empty? && below_max_health?
      warrior.rest!
    elsif space.enemy?
      warrior.attack!
    elsif far_off_enemy?(:forward)
      shoot_enemy
    elsif space.empty?
      warrior.walk!
    elsif space.wall?
      warrior.pivot!(:backward)
    elsif space.stairs?
      warrior.walk!
    end
  end

  # CHECKS TO SEE IF THE HERO IS CURRENTLY TAKING DAMAGE
  def taking_damage?
    if warrior.health < health
      true
    else
      false
    end
  end

  # CHECKS TO SEE IF HERO IS BELOW MAX HEALTH
  def below_max_health?
    warrior.health < MAX_HEALTH
  end

  # CHECKS TO SEE IF HERO HAS LOW HEALTH
  def low_health?
    health < LOW_HEALTH
  end

  # ACTIONS FOR IF THE HERO IS TAKING DAMAGE
  def taking_damage_action
    if space(:backward).empty? && low_health?
      warrior.walk!(:backward)
    elsif space.empty?
      warrior.walk!
    elsif space.enemy?
      warrior.attack!
    end
  end

  # RETURNS AN ARRAY OF THREE SPACES
  def look_ahead(direction)
    looking_array = warrior.look(direction)
  end

  # CHECKS IF THERE IS AN ENEMY IN THE TWO SPACES PAST THE IMMEDIATE SPACE
  def far_off_enemy?(direction)
    if look_ahead(direction)[2].enemy?
      true
    elsif look_ahead(direction)[1].enemy?
      true
    else
      false
    end
  end

  def enemy_behind?
    if far_off_enemy?(:backward)
      true
    elsif look_ahead(:backward)[0].enemy?
      true
    else
      false
    end
  end

  def shoot_enemy
    if look_ahead(:forward)[2].enemy?
      warrior.shoot!
    elsif look_ahead(:forward)[1].enemy?
      warrior.shoot!
    end
  end

  # CHECKS IF THERE IS A CAPTIVE IN A SPECIFIC SPACE IN DIRECTION FACING
  def far_off_captive?(the_space)
    if look_ahead(:forward)[the_space].captive?
      true
    else
      false
    end
  end

  # CHECKS IF THERE IS A CAPTIVE IN ANY SPACE IN DIRECTION FACING
  def captive_in_front?
    if far_off_captive?(0)
      true
    elsif far_off_captive?(1)
      true
    elsif far_off_captive?(2)
      true
    else
      false
    end
  end

  # RESCUING A CAPTIVE ACTIONS
  def rescue_captive_action
    if far_off_captive?(0)
      warrior.rescue!
    elsif far_off_captive?(1)
      warrior.walk!
    elsif far_off_captive?(2)
      warrior.walk!
    end
  end

  def it_came_from_behind
    if space(:backward).enemy?
      warrior.attack!(:backward)
    elsif enemy_behind?
      warrior.shoot!(:backward)
    end
  end

end
