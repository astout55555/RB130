# take input (array), and output new array of elements for which block returns true
# do not mutate original array
# 
# 
# 

## method implementation

def select(arr)
  results = []
  arr.each do |element|
    results << element if yield(element)
  end
  results
end

## method invocation / test cases

array = [1, 2, 3, 4, 5]

select(array) { |num| num.odd? }
# => [1, 3, 5]
select(array) { |num| puts num }
# outputs 1 through 5 on separate lines, then returns:
# => [], because "puts num" returns nil and evaluates to false
select(array) { |num| num + 1 }
# => [1, 2, 3, 4, 5], because "num + 1" evaluates to true
