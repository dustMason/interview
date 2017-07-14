# A building has 100 floors. One of the floors is the highest floor an egg can
# be dropped from without breaking.

# If an egg is dropped from above that floor, it will break. If it is dropped
# from that floor or below, it will be completely undamaged and you can drop the
# egg again.

# Given two eggs, find the highest floor an egg can be dropped from without
# breaking, with as few drops as possible.

class EggDropper
  def initialize highest_floor
    @highest_floor = highest_floor
    @breaks = 0
    @drops = 0
  end
  
  def drop
    current = 10
    best = 0
    
    # move by tens until we break an egg
    until @breaks == 1 || current == 100 do
      @drops += 1
      if current > @highest_floor
        @breaks += 1
      else
        best = current
      end
      current += 10
    end
      
    # then go back to last safe floor and move by twos until we break next egg
    current = best + 2
    until @breaks == 2 || current >= 100 do
      @drops += 1
      if current > @highest_floor
        @breaks += 1
        best = current - 1
      end
      current += 2
    end
    
    return @drops
  end
end

worst_case = (0..99).reduce do |acc, f|
  drops = EggDropper.new(f).drop
  if drops > acc then drops else acc end
end

puts "worst case #{worst_case}"
