# Based on and proudly inspired by http://poignant.guide/dwemthy/

module Roguelike
  class Character
    attr_accessor :pos

    # Get a metaclass for this class
    def self.metaclass; class << self; self; end; end

    def self.traits *arr
      return @traits if arr.empty?

      # 1. Set up accessors for each variable
      attr_accessor *arr

      # 2. Add a new class method to for each trait.
      arr.each do |a|
        metaclass.instance_eval do
          define_method a do |val|
            @traits ||= {}
            @traits[a] = val
          end
        end
      end

      # 3. For each monster, the `initialize' method
      #    should use the default number for each trait.
      class_eval do
        define_method :initialize do
          self.class.traits.each do |k,v|
            instance_variable_set("@#{k}", v)
          end
        end
      end

    end

    traits :life, :strength, :charisma, :weapon, :symbol
    
    def to_s
      symbol
    end
    
    def name
      self.class.name.split("::").last
    end

    # This method applies a hit taken during a fight.
    def hit damage
      out = ''
      p_up = rand charisma
      if p_up % 9 == 7
        @life += p_up / 4
        out << "[#{self.name} magick powers up #{p_up}!]\n"
      end
      @life -= damage
      out << "[#{self.name} has died.]\n" if @life <= 0
      out
    end

    # This method takes one turn in a fight.
    def fight enemy, weapon
      if life <= 0
        return "You are dead."
      end
      
      out = ''

      # Attack the opponent
      your_hit = rand(strength + weapon)
      out << "[You hit the #{enemy.name} with #{your_hit} points of damage!]\n"
      out << enemy.hit(your_hit)

      # Retaliation
      if enemy.life > 0
        enemy_hit = rand(enemy.strength + enemy.weapon)
        out << "[The #{enemy.name} hit with #{enemy_hit} points of damage!]\n"
        out << self.hit(enemy_hit)
      end
      out
    end

  end
end
