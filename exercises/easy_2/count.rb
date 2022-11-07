## same as count_items.rb exercise, except:
# method must take an arbitrarily long list of args instead of a single array

## implementation

def count(*args)
  true_count = 0

  args.each do |val|
    true_count += 1 if yield(val)
  end

  true_count
end

## test cases:

p count(1, 3, 6) { |value| value.odd? } == 2
p count(1, 3, 6) { |value| value.even? } == 1
p count(1, 3, 6) { |value| value > 6 } == 0
p count(1, 3, 6) { |value| true } == 3
p count() { |value| true } == 0
p count(1, 3, 6) { |value| value - 6 } == 3
