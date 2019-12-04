# PART 1

class Wire
  attr_accessor :x_axis, :y_axis, :store

  def initialize(steps:, existing_points:)
    @x_axis = 0
    @y_axis = 0

    @steps = steps

    @existing_points = existing_points

    @store = {}
  end

  def closest
    @store.min_by { |_k, v| v }
  end

  def process
    @steps.each do |step|
      record(step)
    end
  end

  def input(point)
    p "point #{point}"
    distance = point.sum(&:abs)
    @store[point] = distance
  end

  def record(step)
    p "x_axis #{x_axis}"
    p "y_axis #{y_axis}"
    direction = step.first
    p "direction: #{direction}"

    amount = step[1..-1].to_i
    p "amount : #{amount}"

    case direction
    when 'L'
      left_axis = @x_axis - amount

      p "left_axis: #{left_axis}"

      (left_axis..@x_axis).each do |n|
        point = [n, @y_axis]
        input(point)
      end

      @x_axis = left_axis
    when 'D'
      down_axis = @y_axis - amount

      p "down_axis #{down_axis}"

      (down_axis..@y_axis).each do |n|
        point = [@x_axis, n]
        input(point)
      end

      @y_axis = down_axis
    when 'U'
      up_axis = @y_axis + amount

      p "up_axis: #{up_axis}"

      (@y_axis..up_axis).each do |n|
        point = [@x_axis, n]
        input(point)
      end

      @y_axis = up_axis
    when 'R'
      right_axis = @x_axis + amount
      p "right_axis #{right_axis}"

      (@x_axis..right_axis).each do |n|
        point = [n, @y_axis]
        input(point)
      end

      @x_axis = right_axis
    end
  end
end

class FirstWire < Wire
end

class SecondWire < Wire
  attr_accessor :existing_points

  def input(point)
    return unless @existing_points[point]

    super
  end
end

# PART 2

# example  third_wire = Wire.new(steps: "R75,D30,R83,U83,L12,D49,R71,U7,L72".split(','), existing_points:nil)
class Wire
  attr_accessor :x_axis, :y_axis, :store, :counter

  ORIGIN = [0, 0].freeze

  def initialize(steps:, existing_points: nil)
    @steps = steps
    @existing_points = existing_points
    wire_reset
  end

  def wire_reset
    @x_axis = 0
    @y_axis = 0
    @counter = 0
    @store = {}
  end

  def closest
    @store.delete(ORIGIN)
    @store.min_by { |_k, v| v }
  end

  def process
    @steps.each do |step|
      record(step)
    end
  end

  def input(point)
    @counter += 1
    p "counter: #{@counter}"
    p "point #{point}"

    return if @store[point]

    @store[point] = @counter
  end

  def record(step)
    p "x_axis #{@x_axis}"
    p "y_axis #{@y_axis}"
    direction = step.first
    p "direction: #{direction}"

    amount = step[1..-1].to_i
    p "amount : #{amount}"

    case direction
    when 'L'
      left_axis = @x_axis - amount

      p "left_axis: #{left_axis}"

      (@x_axis - 1).downto(left_axis) do |n|
        point = [n, @y_axis]
        input(point)
      end

      @x_axis = left_axis
    when 'D'
      down_axis = @y_axis - amount

      p "down_axis #{down_axis}"

      (@y_axis - 1).downto(down_axis) do |n|
        point = [@x_axis, n]
        input(point)
      end

      @y_axis = down_axis
    when 'U'
      up_axis = @y_axis + amount

      p "up_axis: #{up_axis}"

      (@y_axis + 1).upto(up_axis) do |n|
        point = [@x_axis, n]
        input(point)
      end

      @y_axis = up_axis
    when 'R'
      right_axis = @x_axis + amount
      p "right_axis #{right_axis}"

      (@x_axis + 1).upto(right_axis) do |n|
        point = [n, @y_axis]
        input(point)
      end

      @x_axis = right_axis
    end
  end
end

# example: fourth_wire = SecondWire.new(steps: "U62,R66,U55,R34,D71,R55,D58,R83".split(','), existing_points: third_wire.store)
class SecondWire < Wire
  attr_accessor :existing_points

  def input(point)
    @counter += 1
    return if @store[point]
    return unless @existing_points[point]

    @store[point] = @counter + @existing_points[point]
  end
end
