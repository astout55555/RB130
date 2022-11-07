=begin

input: positive integer
output: array of all divisors (in any order)

High level algorithm:

1. iterate from 1 to integer, test for divisibility
2. store all divisors found

=end

## Method implementation

# this version is too slow for the Further Exploration challenge:
# def divisors(int)
#   all_divisors = [1]

#   if int.odd?
#     num = 3
#     while num < int/2
#       all_divisors << num if int % num == 0
#       num += 2
#     end
#   else
#     2.upto(int/2) do |num|
#       all_divisors << num if int % num == 0
#     end
#   end

#   all_divisors << int unless int == 1

#   all_divisors
# end

# Excellent solution from another student:
def divisors(n)
  limit = Integer.sqrt(n) # nothing above the square root could be a divisor except n
  result = []
  1.upto(limit) do |i|
    if n % i == 0
      result << i 
      result << (n / i) # if i is a divisor, then n / i must be as well
    end
  end
  result.uniq.sort
end

## Test cases:

p divisors(1) == [1]
p divisors(7) == [1, 7]
p divisors(12) == [1, 2, 3, 4, 6, 12]
p divisors(98) == [1, 2, 7, 14, 49, 98]
p divisors(99400891) == [1, 9967, 9973, 99400891]

# FE Challenge:
p divisors(999962000357) == [1, 999979, 999983, 999962000357]
