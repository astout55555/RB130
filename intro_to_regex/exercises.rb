### 1: Write a method that returns true if argument looks like a URL, otherwise false.

## Implementation

def url?(string)
  !!string.match(/\Ahttps?:\/\/\S+\.com\z/) # could also use String#match?
end

## Examples:

url?('http://launchschool.com')   # -> true
url?('https://example.com')       # -> true
url?('https://example.com hello') # -> false
url?('   https://example.com')    # -> false

### 2: write a method which returns all the fields in a haphazardly formatted string
# fields may be separated by one or more spaces, tabs, and/or commas

## Implementation:

def fields(string)
  string.split(/[ ,\t]+/)
end

## Examples:

fields("Pete,201,Student")
# -> ["Pete", "201", "Student"]

fields("Pete \t 201    ,  TA")
# -> ["Pete", "201", "TA"]

fields("Pete \t 201")
# -> ["Pete", "201"]

fields("Pete \n 201")
# -> ["Pete", "\n", "201"]

### 3: write a method that changes first arithmetic operator in a string to a '?'
  # and returns new string (does not mutate the original string)

## Implementation:

def mystery_math(string_equation)
  string_equation.sub(/[+\-\/*]/, '?')
end

## Examples:

mystery_math('4 + 3 - 5 = 2')
# -> '4 ? 3 - 5 = 2'

mystery_math('(4 * 3 + 2) / 7 - 1 = 1')
# -> '(4 ? 3 + 2) / 7 - 1 = 1'

### 4: same thing except changes all of them to a '?' instead of just the first

## Implementation:

def mysterious_math(string_equation)
  string_equation.gsub(/[+\-\/*]/, '?')
end

## Examples:

mysterious_math('4 + 3 - 5 = 2')           # -> '4 ? 3 ? 5 = 2'
mysterious_math('(4 * 3 + 2) / 7 - 1 = 1') # -> '(4 ? 3 ? 2) ? 7 ? 1 = 1'

### 5: write a method that changes the first occurrence
  # of the word apple, blueberry, or cherry in a string to 'danish'

## Implementation:

def danish(sentence)
  sentence.sub(/\b(apple|blueberry|cherry)\b/, 'danish')
end

## Examples:

danish('An apple a day keeps the doctor away')
# -> 'An danish a day keeps the doctor away'

danish('My favorite is blueberry pie')
# -> 'My favorite is danish pie'

danish('The cherry of my eye')
# -> 'The danish of my eye'

danish('apple. cherry. blueberry.')
# -> 'danish. cherry. blueberry.'

danish('I love pineapple')
# -> 'I love pineapple'

### Challenge! 6: method that changes dates formatted 2022-11-19 to 19.11.2022
  # must use regex and methods described in this section of LS regex book

## Implementation:

# def format_date(date_string) # whoops, I did it without regex...
#   date_pieces = date_string.split('-')
#   reordered_date = date_pieces.reverse.join('.')
# end

def format_date(date_string)
  date_string.scan(/(\d{4})-(\d{2})-(\d{2})/) do |matchdata|
    if matchdata
      return "#{matchdata[2]}.#{matchdata[1]}.#{matchdata[0]}"
    end
  end
end

# LS solution uses the capture groups as the 2nd arg in String#sub

def format_date(original_date) # uses anchors and doesn't use quantifier, but could
  original_date.sub(/\A(\d\d\d\d)-(\d\d)-(\d\d)\z/, '\3.\2.\1') # #sub reverses the order
end # I didn't know I could reference capture groups outside of the regex itself!

## Examples:

format_date('2016-06-17') # -> '17.06.2016'
format_date('2016/06/17') # -> '2016/06/17' (no change)

### Challenge! 7: now write a method which changes dates from either format,
  # 2022-11-19 or 2022/11/19, to 19.11.2022
  # still use a regex and methods in this section only

## Implementation:

def format_date(date_string) # solved based on LS solution above
  date_string.sub(/\A(\d{4})(\-|\/)(\d{2})\2(\d{2})\z/, '\4.\3.\1')
end # I need a new capture group to keep track of date separator
      # ('.' or '/', but not a mix), then I return the swapped date using other groups

## Examples:

format_date('2016-06-17') # -> '17.06.2016'
format_date('2017/05/03') # -> '03.05.2017'
format_date('2015/01-31') # -> '2015/01-31' (no change)

## LS Solution 1:

def format_date(original_date) # splits problem into 2 parts, solved like before
  original_date.sub(/\A(\d\d\d\d)-(\d\d)-(\d\d)\z/, '\3.\2.\1')
               .sub(/\A(\d\d\d\d)\/(\d\d)\/(\d\d)\z/, '\3.\2.\1')
end

## LS Solution 2:

def format_date(original_date) # saves regex as a variable--you can do that!
  date_regex = /\A(\d\d\d\d)([\-\/])(\d\d)\2(\d\d)\z/
  original_date.sub(date_regex, '\4.\3.\1') # may be less readable with extra capture group
end
