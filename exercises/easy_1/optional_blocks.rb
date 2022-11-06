def compute(arg)
  block_given? ? yield(arg) : 'Does not compute.'
end

int = 5

p compute(int) { |int| int + 3 } == 8

letter = 'a'

p compute(letter) { |letter| letter + 'b' } == 'ab'

name = 'bob'

p compute(name) { |name| name.capitalize } == 'Bob'

p compute(int) == 'Does not compute.'
