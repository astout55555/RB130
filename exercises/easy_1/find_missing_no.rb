=begin

input: sorted array of integers
output: new sorted array of all missing integers between first/last elements of the input

...
alorithm:

-create empty results array
-starting from first element of input, incrementing up until last element value:
  -next if number is included in input
  -otherwise push into results array
-return results array

=end

def missing(input_array)
  results = []
  current_value = input_array[0]
  while current_value < input_array[-1]
    results << current_value unless input_array.include?(current_value)
    current_value += 1
  end
  
  results
end

## Test cases:

p missing([-3, -2, 1, 5]) == [-1, 0, 2, 3, 4]
p missing([1, 2, 3, 4]) == []
p missing([1, 5]) == [2, 3, 4]
p missing([6]) == []
