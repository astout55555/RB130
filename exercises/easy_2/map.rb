=begin

input: array, with a block
output: transformed (new) array with same number of elements
  -new array is made up of return values of yielding to block and passing current element
  -if input array is empty, return empty array

other rules:
-may only use certain methods to iterate:
  -#each, #each_with_object, #each_with_index, #inject, #loop, for, while, or until

algorithm:

init empty results array
iterate over input array with each
  store return value of yielding to block with current element passed in, add to results
return results arr

(can shorten by just using #each_with_object)

=end

## implementation

def map(collection) # FE: like Enumerable#map, when called on a hash it returns an array
  if block_given?
    collection.each_with_object([]) do |element, arr| # even with hashes, last parameter is always the array object, since `element, arr` is not inside `()`
      arr << yield(element)
    end
  else
    collection.to_enum # borrowed from another student solution, to replicate behavior of Enumerable#map with no block passed
  end
end

## test cases:

p map([1, 3, 6]) { |value| value**2 } == [1, 9, 36]
p map([]) { |value| true } == []
p map(['a', 'b', 'c', 'd']) { |value| false } == [false, false, false, false]
p map(['a', 'b', 'c', 'd']) { |value| value.upcase } == ['A', 'B', 'C', 'D']
p map([1, 3, 4]) { |value| (1..value).to_a } == [[1], [1, 2, 3], [1, 2, 3, 4]]

## more test cases, borrowed from a student solution for FE:

p map([1, 3, 6]) { |value| value**2 } == [1, 9, 36] # Arrays work as normal
p map([1, 3, 6]) { |val1, val2| val2 } == [nil, nil, nil]
# `val2` is assigned to `nil` (since there is no 2nd block parameter before the final object param)
p map({ a: 1, b: 2, c: 3}) { |key, value| "#{key}: #{value * 2}" } == ["a: 2", "b: 4", "c: 6"]
# Hashes work, because the `element` parameter is the key/value pair
