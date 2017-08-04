module Roguelike
  class Monster < Character; end
    
  class IndustrialRaverMonkey < Monster
    life 46
    strength 35
    charisma 91
    weapon 2
    symbol '🐒'
  end

  class DwarvenAngel < Monster
    life 540
    strength 6
    charisma 144
    weapon 50
    symbol '😇'
  end

  class AssistantViceTentacleAndOmbudsman < Monster
    life 320
    strength 6
    charisma 144
    weapon 50
    symbol '🦑'
  end

  class TeethDeer < Monster
    life 655
    strength 192
    charisma 19
    weapon 109
    symbol '🦌'
  end

  class IntrepidDecomposedCyclist < Monster
    life 901
    strength 560
    charisma 422
    weapon 105
    symbol '🚴'
  end

  class Dragon < Monster
    life 1340     # tough scales
    strength 451  # bristling veins
    charisma 1020 # toothy smile
    weapon 939    # fire breath
    symbol '🐲'
  end
end
