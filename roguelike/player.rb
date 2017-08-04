require "./character"

module Roguelike
  class Player < Character
    traits :inventory
    
    life 1000
    strength 20
    charisma 44
    weapon 200
    inventory []
    
    def to_s
      "&"
    end
    
    def / enemy # SLASH!
      fight enemy, rand(4 + ((enemy.life % 10) ** 2))
    end
    
    def eat
      health = rand charisma
      @life += health
    end
  end
end
