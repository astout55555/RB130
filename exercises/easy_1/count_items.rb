=begin

input: array (can be empty, can contain integers or strings), with a block that returns true or false
output: integer (count of number of times block returns true)

algorithm:

make use of the `true_count` set-up from #one? from other exercise, except no limits
return true_count instead of true/false

=end

## method implementation

# def count(array)
#   true_count = 0
  
#   if block_given?
#     array.each { |element| true_count += 1 if yield(element) }
#   end

#   true_count
# end

## FE challenge: solve the problem without using #each, #loop, #while, or #until

# empty array duplicate while testing outcome of each element
# execute code number of times equal to original size of array

def count(array)
  true_count = 0
  working_array = array.dup

  if block_given?
    working_array.size.times do |_|
      element = working_array.shift
      true_count += 1 if yield(element)
    end
  end

  true_count
end

## test cases:

p count([1,2,3,4,5]) { |value| value.odd? } == 3
p count([1,2,3,4,5]) { |value| value % 3 == 1 } == 2
p count([1,2,3,4,5]) { |value| true } == 5
p count([1,2,3,4,5]) { |value| false } == 0
p count([]) { |value| value.even? } == 0
p count(%w(Four score and seven)) { |value| value.size == 5 } == 2
