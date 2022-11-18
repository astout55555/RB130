# Group 1
my_proc = proc { |thing| puts "This is a #{thing}." } # #proc works like Proc.new
puts my_proc
puts my_proc.class
my_proc.call
my_proc.call('cat')

## Notes:

# calling #puts and passing it a proc results in a string output representing the proc
# similar to calling #puts and passing it some custom object,
# includes hexidecimal representation of object's position in memory,
# but instead of listing its instance variables and their values,
# shows the name of the file and the line on which the proc was initialized.
# this is meaningful because it shows where the binding of the proc was formed,
# since a proc is a type of closure, which will carrry that binding with it.

# when called without an argument, the proc executes with the block param assigned nil

# Group 2
my_lambda = lambda { |thing| puts "This is a #{thing}." }
my_second_lambda = -> (thing) { puts "This is a #{thing}." }
puts my_lambda # these two return the same details, except which line they are initialized on
puts my_second_lambda # seeems to just be different syntax for initializing lambdas.
puts my_lambda.class # returns `Proc`! lambdas must be a type of Proc?
my_lambda.call('dog')
# my_lambda.call raises an ArgumentError because lambdas have strict arity, requires 1 arg
# my_third_lambda = Lambda.new { |thing| puts "This is a #{thing}." } # raises a NameError

## Notes:

# I was expecting the ArgumentError because I knew that lambdas were like procs except
# lambdas have strict arity, meaning they require you to pass in a specific number of
# args, like methods. Procs and blocks have lenient arity, so they accomodate you when
# you pass in fewer or extra args compared to the number of parameters.
# However, I was surprised by 2 things, which appear related.
# First, the class of the lambda was `Proc`! It seems like lambdas are essentially
# procs which have been altered to have strict arity.
# This is borne out by the 2nd unexpected error, the NameError when we try to run the
# code `Lambda.new`. It seems like `Lambda` is just not a class we can instantiate from.
# Other than these details, lambdas seem to work just like procs.
# Although the fact it is a lambda is shown also when you output the object.

# Group 3
def block_method_1(animal)
  yield
end

block_method_1('seal') { |seal| puts "This is a #{seal}."} # => This is a .
# does not pass the argument to the block when yielding to it
# block_method_1('seal')
# raises a LocalJumpError because no block given but yield keyword is used

# Group 4
def block_method_2(animal)
  yield(animal) # this time the arg is passed to the block
end

block_method_2('turtle') { |turtle| puts "This is a #{turtle}."}
block_method_2('turtle') do |turtle, seal| # seal is not defined, assigned nil
  puts "This is a #{turtle} and a #{seal}." # block is flexible with less args than params
end
# block_method_2('turtle') { puts "This is a #{animal}."} # no block param to use arg
# `animal` raises a NoNameError, with no block param to be assigned nil or 'turtle'

## Analysis

# It appears that a block is an anonymous closure,
# some reusable code that can be passed around and remembers its context (binding).
# A proc is a "permanent block", a block given a name and assigned to a variable,
# which can then be referenced, etc.
# Blocks and procs both have lenient arity,
# and can accomodate being passed fewer or more arguments than they have parameters.
# A lambda is a modified proc. Using special syntax, the proc is turned into a lambda.
# The lambda still functions like a proc and still is an object from the Proc class,
# however, the lambda now has strict arity,
# meaning it requires a specific number of args to match its parameters.
