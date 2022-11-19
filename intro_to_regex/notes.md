# Basic Matching

## All meta-characters (require backslash `\` to 'escape' for literal char usage):

`$`
`^`
`*`
`+`
`?`
`.`
`(`
`)`
`[`
`]`
`{`
`}`
`|`
`\`
`/`

## Concatenation

Adding more characters to a regex means the regex searches for the full concatenated pattern.

## Alternation

Use `(patternA|patternB)` to say either pattern can satisfy the regex match.

## Ignore Case

Ignore case in a regex by adding `/i` to the end (like this: `/regex/i`).

# Character Classes

Use `[]` to indicate that any of the included patterns would satisfy the regex match.

## Symbols which are meta-characters in character classes:

`^`     negation, only used at beginning of pattern
`\`     backslash to escape special chars
`-`     indicates a range (e.g. `[A-Za-z]`)
`[`     opens a character class
`]`     closes a character class

# Chacter Class Shortcuts

## Symbols and their meanings:

`.`       any char except newline chars, unless adding `/m` multiline option at end
  (inside `[]` a `.` is literal)
`\s`      whitespace chars
  (including space ` `, tab `\t`, vertical tab `\v`, carriage return `\r`, line feed `\n`,  and form feed `\f`)
`\S`      non-whitespace chars
`\d`      decimal digit (0-9)
`\D`      not a decimal digit
`\h`      hexadecimal digit (0-9, A-F, a-f) (only in Ruby)
`\H`      not a hexadecimal digit (only in Ruby)
`\w`      word character (a-z, A-Z, 0-9, _)
`\W`      non-word character (punctuation, whitespace, special chars)

# Anchors

## Symbols and their meanings:

`^`       when at start of pattern, means start of line
`\A`      when at start of pattern, means start of string (preferred)
`$`       when at end of pattern, means end of line
`\z`      when at end of pattern, means end of string (preferred)
`\Z`      when at end of pattern, means end of string except newline
`\b`      word boundary (note: inside `[]` this means a backspace character)
  (between word and non-word chars--words can include numeric chars--
    beginning/ending of lines if adjacent char is a word char)
`\B`      non-word boundary (note: does not work inside `[]`)
  (between word and word, or non-word and non-word chars,
    beginning/ending of lines if adjacent char is a non-word char)

# Quantifiers

## Symbols and their meanings:

Note: quantifier symbols apply to the pattern to their left
(can be a collection of symbols if in parentheses)

`*`         0 or more
`+`         1 or more
`?`         0 or 1
  (note: different from adding `?` after a quantifier, which makes the pattern 'lazy')
  (i.e: it will find the shortest matching pattern instead of longest--'greedy' is default)
`{m}`       exactly m occurrences of pattern
`{m,}`      m or more
`{m,n}`     m or more, but not more than n

## Examples of extended regex syntax:

```ruby
### Challenge Exercise 11: find each line which has 3 OR 6+ comma-separated numbers

# solution 1

/
  (                  # Grouping for alternation
    ^(\d+,){2}\d+$   # Match precisely 3 numbers on a line
    |                # or
    ^(\d+,){5,}\d+$  # Match 6 or more numbers on a line
  )                  # All done
/x                   # the `x` is required on the final line for extended syntax

# solution 2:

/
  ^                  # Start of line
  (\d+,){2}          # 2 numbers at start
  (                  # followed by...
    (\d+,){3,}       #    at least 3 more numbers
  )?                 #    that are optional
  \d+                # followed by one last number
  $                  # end of line
/x                   # extended syntax allows you to leave explanatory notes on each line

# in a real program, it might make more sense to use two different, more readable regex:

if text.match(/^(\d+,){2}\d+$/) || text.match(/^(\d+,){5,}\d+$/)
```

# Using Regex in Ruby (and JavaScript)

The regex methods I'll use most often are found in the String class, not the Regexp class.

## `String#match`

It returns a MatchData object, which is truthy, or else nil. Used like so:

`fetch_url(text) if text.match(/\Ahttps?:\/\/\S+\z/)`

The MatchData object (or array in JavaScript) responds to `[0]`, `[1]`, `[2]` etc.

### `String#=~`

Example:

`fetch_url(text) if text =~ /\Ahttps?:\/\/\S+\z/`

Similar to `#match` except return index within the string at which the regex matched, or nil.

## Capture Groups

`(` and `)` not only group patterns, but also form 'capture groups' which can be referenced later in the regex, like so:

`/(['"]).+?\1/`

This example allows us to match quoted strings without mixing single and double-quotes at the beginning and end of the quoted string. We capture the initial character, and then reference it with `\1`--the first capture group in the regex. We can store/reference up to 9 in a single regex. It's also possible to name them.

## Transformations

E.g.:

```ruby
text = %(We read "War of the Worlds".)
puts text.sub(/(['"]).+\1/, '\1The Time Machine\1')
# prints: We read "The Time Machine".
```

Avoid using double quotes to avoid having to use double backslashes (`\\1`).
