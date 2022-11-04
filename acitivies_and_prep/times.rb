# New #times method implementation (walkthrough)

# method implementation
def times(number)
  counter = 0
  while counter < number do
    yield(counter)
    counter += 1
  end

  number # return the original method argument to match behavior of `Integer#times`
end

# Code execution below should work as expected:

# method invocation
times(5) do |num|
  puts num
end

# Output:
# 0
# 1
# 2
# 3
# 4
# => 5
