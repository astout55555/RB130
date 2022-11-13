=begin

input: array (of integers only, but could be empty), and a block
output: element with the largest value (or nil if array is empty)

rules:
-usual list of allowed iteration methods

algorithm:

return nil if array is empty
init local var `max_element` to first element
init local var `max_value` to return of yielding first element to block
iterate through array, skipping first element
  yield current val to block
  if return value of block is is higher than `max_value`
    reassign max_value
    reassign max_element
return max_element


=end

## implementation

def max_by(array)
  return nil if array.empty?
  max_value = yield(array[0])
  max_element = array[0]

  count = 1
  while count < array.size
    val = yield(array[count])
    if val > max_value
      max_value = val
      max_element = array[count]
    end
    count += 1
  end
  max_element
end

## test cases

p max_by([1, 5, 3]) { |value| value + 2 } == 5
p max_by([1, 5, 3]) { |value| 9 - value } == 1
p max_by([1, 5, 3]) { |value| (96 - value).chr } == 1
p max_by([[1, 2], [3, 4, 5], [6]]) { |value| value.size } == [3, 4, 5]
p max_by([-7]) { |value| value * 3 } == -7
p max_by([]) { |value| value + 5 } == nil

## LS solution:

def max_by(array)
  return nil if array.empty?

  max_element = array.first
  largest = yield(max_element) # somewhat cleaner code here

  array[1..-1].each do |item| # iterating over specified range of array is neater
    yielded_value = yield(item) # `yielded_value` is a better local var name
    if largest < yielded_value
      largest = yielded_value
      max_element = item
    end
  end

  max_element
end
