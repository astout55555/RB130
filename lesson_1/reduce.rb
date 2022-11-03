# input: array, and optional initial value for accumulator
# output: integer (sum of all elements)
# my implementation of #reduce must take a block which takes 2 arguments
# accumulator and current number (acc, num)
# with each iteration, accumulator is set to return value of block
# at end of iteration, return accumulator

# 
# 
# 

## Method implementation

def reduce(arr, initial_value=nil)
  array = arr.dup

  if initial_value
    accumulator = initial_value
  else
    accumulator = array.shift
  end

  array.each do |element|
    accumulator = yield(accumulator, element)
  end

  accumulator
end

## Tests/examples:

array = [1, 2, 3, 4, 5]

reduce(array) { |acc, num| acc + num }
# => 15
reduce(array, 10) { |acc, num| acc + num }
# => 25
# reduce(array) { |acc, num| acc + num if num.odd? }
# => NoMethodError: undefined method `+' for nil:NilClass

## Extra challenge tests/examples:

reduce(['a', 'b', 'c']) { |acc, value| acc += value }     # => 'abc'
reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value } # => [1, 2, 'a', 'b']
