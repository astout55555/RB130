=begin

input: 2 arrays of equal size
output: 1 array made of pairs of elements with same index position from arr 1 and 2
  -output array should have same number of sub-arrays as original arrays have elements

notes:
-do not mutate original arrays
-do not use Array#zip

algorithm:

init empty results array
use loop with index counter
  for each index number, fill temp sub-array with 1 element from each input arr
  push sub-array into results array
output results array

=end

## implementation

def zip(arr1, arr2)
  results = []

  index = 0
  while index < arr1.size
    sub_arr = []
    sub_arr << arr1[index]
    sub_arr << arr2[index]
    results << sub_arr
    index += 1
  end

  results
end

## test case:

p zip([1, 2, 3], [4, 5, 6]) == [[1, 4], [2, 5], [3, 6]]

## LS notes:
# since this is basically what #each_with_index does, we can simply do this:

def zipper(array1, array2)
  result = []
  array1.each_with_index do |element, index|
    result << [element, array2[index]]
  end
  result
end

# or even more succinctly:

def zipper(array1, array2)
  array1.each_with_index.with_object([]) do |(element, index), result|
    result << [element, array2[index]]
  end
end
