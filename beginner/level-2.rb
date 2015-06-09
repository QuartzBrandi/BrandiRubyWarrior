
class Player
  def play_turn(warrior)
    if warrior.feel.empty?
      warrior.walk!
    else warrior.feel.enemy?
      warrior.attack!
    end
  end
end
