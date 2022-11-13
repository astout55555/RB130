=begin

input: array, and a block
output: returns the original array. yields each element and its index to the block.

rules:
-may only use #each, #each_with_object, #inject, #loop, for, while, or until to iterate

high level algorithm:

1. pass each value and its index to the block as args
2. return original array

algorithm:

1.
iterate through array with a loop and an index counter
  on each iteration, pass value and index to block
2.
return array

=end

## implementation

def each_with_index(array)
  index = 0
  while index < array.size
    yield(array[index], index)
    index += 1
  end
  array
end

## test cases

result = each_with_index([1, 3, 6]) do |value, index|
  puts "#{index} -> #{value**index}"
end

puts result == [1, 3, 6]
# should output:
# 0 -> 1
# 1 -> 3
# 2 -> 36
# true

## LS Solution:

def each_with_index(array)
  index = 0
  array.each do |item| # #each returns the array already, saving a line of code
    yield(item, index)
    index += 1 # can increment counters within block for #each
  end
end
