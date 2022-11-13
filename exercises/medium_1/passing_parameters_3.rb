### Given this starting code:

items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "We've finished gathering!"
end

## Method Call 1

gather(items) do |*produce, grain|
  puts produce.join(', ')
  puts grain
end

## Output 1

# Let's start gathering food.
# apples, corn, cabbage
# wheat
# We've finished gathering!

## Method Call 2

gather(items) do |fruit, *veggies, grain|
  puts fruit
  puts veggies.join(', ')
  puts grain
end

## Output 2

# Let's start gathering food.
# apples
# corn, cabbage
# wheat
# We've finished gathering!

## Method Call 3

gather(items) do |fruit, *non_fruit|
  puts fruit
  puts non_fruit.join(', ')
end

## Output 3

# Let's start gathering food.
# apples
# corn, cabbage, wheat
# We've finished gathering!

## Method Call 4

gather(items) do |apples, corn, cabbage, wheat|
  puts "#{apples}, #{corn}, #{cabbage}, and #{wheat}"
end

## Output 4

# Let's start gathering food.
# apples, corn, cabbage, and wheat
# We've finished gathering!
