require 'pry-byebug'

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative 'text'

class TextTest < Minitest::Test
  def setup
    @file = File.open('sample.txt', 'r')
    @file_text = @file.read # apparently, reading a file empties it out! if I try to read
  end # the file a second time, it will return an empty string

  def test_swap
    expected_result = @file_text.gsub('a', 'e')
    new_text = Text.new(@file_text).swap('a', 'e')

    assert_equal expected_result, new_text
  end

  def test_word_count
    expected_total_words = @file_text.split.count

    assert_equal expected_total_words, Text.new(@file_text).word_count
  end

  def teardown
    @file.close
  end
end
