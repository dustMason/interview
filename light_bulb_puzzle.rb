class Dropper

  attr_reader :current_floor

  def initialize breaks_on, total_floors
    @breaks_on = breaks_on
    @current_floor = 0
    @rough_pass_step_size = (total_floors / Math.sqrt(total_floors)).floor
    solve
  end

  private

  def solve
    [@rough_pass_step_size, 1].each { |step_size| test_pass step_size }
    @current_floor += 1
  end

  def test_pass step_size
    @current_floor += step_size while @current_floor < @breaks_on
    @current_floor -= step_size
  end

end
