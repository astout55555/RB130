=begin

input: array, and a block
output:
  -yield the contents of the array to the block
  -block params should assign contents to params
    -ignoring first two elements
    -assigning all remaining elements to a single param as an array

=end

def after_first_two(array)
  if block_given?
    yield(array)
  end
end

arr = [1, 2, 'a', 'b', 'c']

after_first_two(arr) { |_, _, *letters| p letters }
