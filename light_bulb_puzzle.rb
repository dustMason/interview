class Dropper

  attr_reader :current_floor, :iterations

  def initialize breaks_on, total_floors, number_of_bulbs
    @breaks_on = breaks_on
    @number_of_bulbs = number_of_bulbs
    @total_floors = total_floors
    @current_floor = 0
    @iterations = 0
  end

  def solve
    testing_jump_amount = @total_floors
    while @number_of_bulbs > 1
      testing_jump_amount = Math.sqrt(testing_jump_amount).floor
      break if testing_jump_amount == 1
      test_pass testing_jump_amount
      @number_of_bulbs -= 1
    end
    test_pass 1
    @current_floor + 1
  end

  private

  def test_pass step_size
    while @current_floor < @breaks_on
      @current_floor += step_size
      @iterations += 1
    end
    @current_floor -= step_size
  end

end

worst_case_iterations = 0
height = 100
bulbs = 3
(1..height).each do |floor|
  drop = Dropper.new(floor, height, bulbs)
  raise Error if drop.solve != floor
  worst_case_iterations = drop.iterations if drop.iterations > worst_case_iterations
end
puts "Worst case: #{worst_case_iterations} given #{bulbs} bulbs and a #{height} story building"
