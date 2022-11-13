items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  yield(items)
end

gather(items) do |items|
  puts "Let's start gathering food."
  puts "#{items.join(', ')}"
  puts "Nice selection of food we have gathered!"
end

## LS Solution:

items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food." # keeps the pre and post output
  yield(items) # only yields the items to block for display
  puts "Nice selection of food we have gathered!" # example of sandwich code around block
end

gather(items) { |produce| puts produce.join('; ') } # example block implementation

gather(items) do |produce| # alternative example of how user could implement block
  puts "We've gathered some vegetables: #{produce[1]} and #{produce[2]}"
end
