=begin

## Part 1: define #each_cons to work for arrays like Enumberable#each_cons

input: array, and a block
output:
  -yields each set of 2 consecutive elements to block (overlapping)
  -returns nil

rules:
  -usual list of iterators allowed

algorithm:

from array[0..-2] (iterating with each_with_index)
  yield current element and next element (index + 1) to block
return nil

## Part 2:

modify #each_cons to take argument that specifies how many elements to process at once

algorithm:

init local var `end_idx` to (-1 - at_a_time)
iterate with each_with_index through array [0..end_idx]
  init local var to_yield to empty array
  init local var counter to 0
  until counter == at_a_time
    push array[idx + counter] into to_yield
    counter += 1
  yield *to_yield to block
return nil

=end

## implmentation

def each_cons(array, at_a_time)
  array[0..-at_a_time].each_index do |idx|
    to_yield = []
    counter = 0
    while counter < at_a_time
      to_yield << array[idx + counter]
      counter += 1
    end
    yield(*to_yield)
  end

  nil
end

## test cases, part 1

# hash = {}
# result = each_cons([1, 3, 6, 10]) do |value1, value2|
#   hash[value1] = value2
# end
# p result == nil
# p hash == { 1 => 3, 3 => 6, 6 => 10 }

# hash = {}
# result = each_cons([]) do |value1, value2|
#   hash[value1] = value2
# end
# p hash == {}
# p result == nil

# hash = {}
# result = each_cons(['a', 'b']) do |value1, value2|
#   hash[value1] = value2
# end
# p hash == {'a' => 'b'}
# p result == nil

## test cases, part 2

hash = {}
each_cons([1, 3, 6, 10], 1) do |value|
  hash[value] = true
end
p hash == { 1 => true, 3 => true, 6 => true, 10 => true }

hash = {}
each_cons([1, 3, 6, 10], 2) do |value1, value2|
  hash[value1] = value2
end
p hash == { 1 => 3, 3 => 6, 6 => 10 }

hash = {}
each_cons([1, 3, 6, 10], 3) do |value1, *values|
  hash[value1] = values
end
p hash == { 1 => [3, 6], 3 => [6, 10] }

hash = {}
each_cons([1, 3, 6, 10], 4) do |value1, *values|
  hash[value1] = values
end
p hash == { 1 => [3, 6, 10] }

hash = {}
each_cons([1, 3, 6, 10], 5) do |value1, *values|
  hash[value1] = values
end
p hash == {}

## LS solution:

def each_cons(array, n)
  array.each_index do |index|
    break if index + n - 1 >= array.size # break condition instead of while condition
    yield(*array[index..(index + n - 1)]) # * operator directly on array slice
  end # code is much more concise, but I think mine is perhaps easier to read
  nil
end