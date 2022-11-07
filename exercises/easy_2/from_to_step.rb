=begin

input: 3 integers (start, end, step), and a block
output: block will print out current value between start/end for each "step"
  -can return whatever seems most useful...
  -I choose: a range formed from start and end values

algorithm:

init value var at start
until value >= end
  yield value to block
  increment value by step
return (start..end)

=end

## implementation

def step(start, ending, increment)
  value = start
  until value > ending
    yield(value)
    value += increment
  end
  (start..ending) # LS solution suggests either `value`, `nil`, or the last value returned by the block
end

## test case:

p step(1, 10, 3) { |value| puts "value = #{value}" } == (1..10)

## expected output:
# value = 1
# value = 4
# value = 7
# value = 10
