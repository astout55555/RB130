=begin

input: array of values (could be empty array), with a block
output: selected array of values
  -starting from element which first returns a falsey value when passed to the block
  -includes the rest of the elements after that first one (regardless of block)
  -returns empty array if no falsey value found or input array was empty

other rules:
  -only use #each, #each_with_object, #each_with_index, #inject, #loop, for, while, or until to iterate

algorithm:

init empty results array
init found_falsey var to false
iterate over input array
  if block returns falsey value, reassign found_falsey to true
  add element to results if found_falsey is true
return results array  

=end

## implementation

def drop_while(array)
  results = []
  found_falsey = false
  if block_given?
    array.each do |element|
      found_falsey = true unless yield(element)
      results << element if found_falsey
    end
  end
  results
end

## LS solution stops partway through, then uses Array#[] to retrieve the results

def drop_while(array)
  index = 0
  while index < array.size && yield(array[index])
    index += 1
  end

  array[index..-1]
end

## test cases:

p drop_while([1, 3, 5, 6]) { |value| value.odd? } == [6]
p drop_while([1, 3, 5, 6]) { |value| value.even? } == [1, 3, 5, 6] # not a typo!
p drop_while([1, 3, 5, 6]) { |value| true } == []
p drop_while([1, 3, 5, 6]) { |value| false } == [1, 3, 5, 6]
p drop_while([1, 3, 5, 6]) { |value| value < 5 } == [5, 6]
p drop_while([]) { |value| true } == []
