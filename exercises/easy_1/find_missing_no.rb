=begin

input: sorted array of integers
output: new sorted array of all missing integers between first and last elements of the input

...

=end

def missing
  # implementation
end

## Test cases:

missing([-3, -2, 1, 5]) == [-1, 0, 2, 3, 4]
missing([1, 2, 3, 4]) == []
missing([1, 5]) == [2, 3, 4]
missing([6]) == []
