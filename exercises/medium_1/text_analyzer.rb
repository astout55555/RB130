=begin

input: #process takes a block only, which includes a reference to a txt file
output: display # of paragraphs, # of lines, and # of words

rules:
  -only fill out #process implemenation and the blocks passed to it, nothing else

Algorithm:

#process needs to:
  init local var to refer to text of file, with File.read (or with File.open etc...)
  find number of paragraphs, lines, and words, save to vars
  each block is meant to output a different kind of result (paragraphs, lines, words)
  array of totals for each type of chunk should be passed to block
blocks should access correct total needed for output text and display with interpolation

=end

class TextAnalyzer
  def process(file_name) # added argument to allow choice of file to analyze
    # your implementation
    all_text = File.read(file_name)

    text_info = {
      paragraphs: all_text.split("\n\n"),
      lines: all_text.split("\n"),
      words: all_text.split
    }

    yield(text_info)
  end
end

analyzer = TextAnalyzer.new
analyzer.process('sample_text.txt') { |text_info| puts "#{text_info[:paragraphs].count} paragraphs" }
analyzer.process('my_text.txt') { |text_info| puts "#{text_info[:lines].count} lines" }
analyzer.process('more_text.txt') { |text_info| puts "#{text_info[:words].count} words" }

## Sample output (from the 3 different files):

# 3 paragraphs
# 4 lines
# 8 words

## LS Solution:

class TextAnalyzer
  def process
    file = File.open('sample_text.txt', 'r') # file opened to be read here
    yield(file.read) # simply pass the file text to the block for processing
    file.close # since code not within {} for File#open, must remember to #close it
  end
end

analyzer = TextAnalyzer.new # processing is done in the block itself
analyzer.process { |text| puts "#{text.split("\n\n").count} paragraphs" }
analyzer.process { |text| puts "#{text.split("\n").count} lines" }
analyzer.process { |text| puts "#{text.split(' ').count} words" }
