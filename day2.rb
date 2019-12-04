# runs opcode
# Use like c = Computer.new(input)
# c.set(noun, verb)
# c.process
# c.scan
class Computer
  attr_accessor :current_state, :first, :second, :third, :fourth # :return_value, :n, :m, :tries, :results
  attr_reader :initial_state

  # class ComputerError < StandardError; end

  def initialize(initial_state)
    @initial_state = initial_state.dup
    @current_state = initial_state.dup
    @results = []
    @tries = 0
  end

  def set(noun, verb)
    @return_value = nil
    @current_state = @initial_state.dup
    @current_state[1] = noun
    @current_state[2] = verb

    @current_state
  end

  def scan
    cap = 99
    0.upto(cap) do |n|
      0.upto(cap) do |m|
        # begin
        # @tries += 1
        # @n = n
        # @m = m

        set(n, m)
        process

        # @results << @return_value
        return [n, m] if @return_value == 19_690_720

        # rescue ComputerError
        #   next
        # end
      end
    end
  end

  def process
    @current_state.each_slice(4) do |slice|
      # raise ComputerError, 'ran out of numbers' if slice.include? nil

      @first, @second, @third, @fourth = slice

      opcode(@first)

      return @return_value if @return_value
    end
  end

  def opcode(number)
    case number
    when 1
      @current_state[@fourth] = @current_state[@second] + @current_state[@third]
    when 2
      @current_state[@fourth] = @current_state[@second] * @current_state[@third]
    when 99
      @return_value = @current_state.first
    else
      # raise ComputerError, 'something went wrong'
    end
  end
end
