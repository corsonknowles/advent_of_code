# PART 1
[83] pry(main)> # runs opcode
[84] pry(main)> class Computer
[84] pry(main)*   attr_accessor :current_state, :first, :second, :third, :fourth, :return_value  
[84] pry(main)*   attr_reader :initial_state  
[84] pry(main)*   
[84] pry(main)*   def initialize(initial_state)  
[84] pry(main)*     @initial_state = initial_state    
[84] pry(main)*     @current_state = initial_state    
[84] pry(main)*   end    
[84] pry(main)*   
[84] pry(main)*   def process  
[84] pry(main)*     @current_state.each_slice(4) do |slice|    
[84] pry(main)*       p slice      
[84] pry(main)*       @first, @second, @third, @fourth = slice      
[84] pry(main)*       
[84] pry(main)*       opcode(@first)      
[84] pry(main)*       
[84] pry(main)*       return @return_value if @return_value      
[84] pry(main)*     end      
[84] pry(main)*   end    
[84] pry(main)*   
[84] pry(main)*   def opcode(number)  
[84] pry(main)*     case number    
[84] pry(main)*     when 1      
[84] pry(main)*       @current_state[@fourth] = @current_state[@second] + @current_state[@third]      
[84] pry(main)*     when 2      
[84] pry(main)*       @current_state[@fourth] = @current_state[@second] * @current_state[@third]      
[84] pry(main)*     when 99      
[84] pry(main)*       @return_value = @current_state.first      
[84] pry(main)*     else      
[84] pry(main)*       raise 'something went wrong'      
[84] pry(main)*     end      
[84] pry(main)*   end    
[84] pry(main)* end  
=> :opcode
[85] pry(main)> Computer.new(a).process 


# PART 2

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
