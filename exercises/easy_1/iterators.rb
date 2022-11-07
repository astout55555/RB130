### Iterators: True for Any? (exercise 6)

=begin

input: array (can be empty) and a block
output: boolean (true if block returns truthy value for any element, otherwise false)

notes:
-empty array should return false regardless of code in block

algorithm:

iterate over each element in array
  pass value to block
  if !(block return value) is false, return false
  return true if return false not triggered

=end

## any? implementation

def any?(collection)
  if block_given?
    collection.each do |element|
      return true if yield(element)
    end
  end

  false
end

## test cases:

any?([1, 3, 5, 6]) { |value| value.even? } == true
any?([1, 3, 5, 7]) { |value| value.even? } == false
any?([2, 4, 6, 8]) { |value| value.odd? } == false
any?([1, 3, 5, 7]) { |value| value % 5 == 0 } == true
any?([1, 3, 5, 7]) { |value| true } == true
any?([1, 3, 5, 7]) { |value| false } == false
any?([]) { |value| true } == false # does not check the block return value because no first element to iterate over with #each

### Iterators: True for All?

def all?(collection)
  if block_given?
    collection.each do |element|
      return false if !yield(element)
    end
  end

  true
end

## test cases:

all?([1, 3, 5, 6]) { |value| value.odd? } == false
all?([1, 3, 5, 7]) { |value| value.odd? } == true
all?([2, 4, 6, 8]) { |value| value.even? } == true
all?([1, 3, 5, 7]) { |value| value % 5 == 0 } == false
all?([1, 3, 5, 7]) { |value| true } == true
all?([1, 3, 5, 7]) { |value| false } == false
all?([]) { |value| false } == true

### Iterators: True for None?

def none?(collection)
  if block_given?
    collection.each do |element|
      return false if yield(element)
    end
  end

  true
end

## test cases:

none?([1, 3, 5, 6]) { |value| value.even? } == false
none?([1, 3, 5, 7]) { |value| value.even? } == true
none?([2, 4, 6, 8]) { |value| value.odd? } == true
none?([1, 3, 5, 7]) { |value| value % 5 == 0 } == false
none?([1, 3, 5, 7]) { |value| true } == false
none?([1, 3, 5, 7]) { |value| false } == true
none?([]) { |value| true } == true

## Interesting alternate LS solution:

def none?(collection, &block) # uses explicit block parameter
  !any?(collection, &block) # passed to #any? as explicit arg to avoid LocalJumpError
end # #none? is just the opposite of #any? so this is all we need

### Iterators: True for One?

def one?(collection)
  true_count = 0
  
  if block_given?
    collection.each do |element|
      true_count += 1 if yield(element)
      return false if true_count > 1
    end
  end

  true_count == 1 ? true : false
end

## test cases:

p one?([1, 3, 5, 6]) { |value| value.even? }    # -> true
p one?([1, 3, 5, 7]) { |value| value.odd? }     # -> false
p one?([2, 4, 6, 8]) { |value| value.even? }    # -> false
p one?([1, 3, 5, 7]) { |value| value % 5 == 0 } # -> true
p one?([1, 3, 5, 7]) { |value| true }           # -> false
p one?([1, 3, 5, 7]) { |value| false }          # -> false
p one?([]) { |value| true }                     # -> false
