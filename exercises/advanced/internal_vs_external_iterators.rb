=begin

Problem:

1. create a new Enumerator object
  -may define what values are being iterated upon
  -one which can iterate over an infinite list of factorials
2. test Enumerator object by printing out the first 7 factorial values starting with `0!`
  -do this using an external iterator
3. see what happens if you print another 3 factorials
  -results should not be correct
4. reset Enumerator using `#rewind`
5. print another 7 factorial values

notes:
  -only need 3 Enumerator methods to complete exercise
  -an Enumerator also implements the Enumerable module

Examples/Test cases:

0! => 1 (by definition)
1! => 1 (by definition)
2! => 2
3! => 6
4! => 24
5! => 125
6! => 720
7! => 5040
8! => 40320
9! => 362880
10! => 3628800

-when externally iterating, results of the 3 additional factorials should continue sequence,
  rather than start over like you might expect

-2nd set of printing 7 factorials after #rewind should be correct

Algorithm:

1.
create new Enumerator object, assign to local var 'factorials'
  -within block, use loop to define sequence of factorials after 0! and 1!
  -include factorial_base (starting at 0) to help keep track of sequence number
  -if factorial_base < 2, then yielded value is 1
  -if factorial_base >= 2, then yielded value is factorial_base * previously yielded value
2.
use 7.times with block that outputs factorials.next to externally iterate
3.
using external iterator again, 3.times, will continue instead of starting over
4.
call #rewind on factorials Enumerator to reset
5.
can again use 7.times external iteration to get values of 0! through 6!

notes:
  -3 Enumerator methods needed: #new, #next, #rewind

=end

factorials = Enumerator.new do |yielder|
  factorial_base = 0
  value = 1
  loop do
    if factorial_base < 2
      yielder << value
    else
      value = (factorial_base * value)
      yielder << value
    end

    factorial_base += 1
  end
end

# internal iteration
puts factorials.take(7)
puts '-------------'

# internal iteration resets between iterations
puts factorials.take(3)
puts '----------------'

# external iteration
7.times do |_|
  puts factorials.next
end
puts '--------------'

# external iteration does not automatically reset between method calls
3.times do |_|
  puts factorials.next
end
puts '--------------'

# can manually reset Enumerator between external iterations
factorials.rewind

# and now the results will restart with more external iteration
7.times do |_|
  puts factorials.next
end

### LS Solution:

factorial = Enumerator.new do |yielder|
  accumulator = 1 # better name for this variable
  number = 0
  loop do # only needs different calculation for 0; 1 * 1 == 1
    accumulator = number.zero? ? 1 : accumulator * number
    yielder << accumulator
    number += 1
  end
end

# External iterators

# using the labeling makes it more obvious what is expected
6.times { |number| puts "#{number}! == #{factorial.next}" }
puts "=========================="
6.times { |number| puts "#{number}! == #{factorial.next}" }
puts "==========================" # and why the above will be 'incorrect'
factorial.rewind
6.times { |number| puts "#{number}! == #{factorial.next}" }
puts "=========================="

# Internal iterators

factorial.each_with_index do |value, number|
  puts "#{number}! == #{value}"
  break if number >= 5 # break needed to prevent infinite iteration
end

## LS Output:

# 0! == 1         # Output of first times loop
# 1! == 1
# 2! == 2
# 3! == 6
# 4! == 24
# 5! == 120
# ==========================
# 0! == 720       # Output of 2nd times loop: note the incorrect output
# 1! == 5040
# 2! == 40320
# 3! == 362880
# 4! == 3628800
# 5! == 39916800
# ==========================
# 0! == 1         # Output of 3rd times loop: this time output is correct
# 1! == 1
# 2! == 2
# 3! == 6
# 4! == 24
# 5! == 120
# ==========================
# 0! == 1         # Output of each_with_index
# 1! == 1
# 2! == 2
# 3! == 6
# 4! == 24
# 5! == 120
