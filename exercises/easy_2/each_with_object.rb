=begin

input: an array, an object (usually a collection), and a block
output:
  -yield each element with the object to the block
  -object value may be updated by each block call.
  -final value of object is returned (original object value if array was empty)

rules:
  -can only use #each, #each_with_index, #inject, #loop, for, while, or until to iterate

algorithm:

iterate through array
  yield value and obj to block
return obj

=end

## implementation

def each_with_object(arr, obj)
  arr.each do |element|
    yield(element, obj)
  end
  obj
end

## test cases

result = each_with_object([1, 3, 5], []) do |value, list|
  list << value**2
end
p result == [1, 9, 25]

result = each_with_object([1, 3, 5], []) do |value, list|
  list << (1..value).to_a
end
p result == [[1], [1, 2, 3], [1, 2, 3, 4, 5]]

result = each_with_object([1, 3, 5], {}) do |value, hash|
  hash[value] = value**2
end
p result == { 1 => 1, 3 => 9, 5 => 25 }

result = each_with_object([], {}) do |value, hash|
  hash[value] = value * 2
end
p result == {}
