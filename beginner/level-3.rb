
class Player
  def play_turn(warrior)
    if warrior.feel.empty? && warrior.health <= 15
      warrior.rest!
    elsif warrior.feel.empty?
      warrior.walk!
    elsif warrior.feel.enemy?
      warrior.attack!
    end
  end
end
