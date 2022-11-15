require 'minitest/autorun'

require_relative 'transaction'

## monkeypatched Transaction to remove output during testing #prompt_for_payment
## this worked but was not the intended solution, could potentially cause other issues too
# class Transaction
#   def prompt_for_payment(input: $stdin)
#     loop do
#       # puts "You owe $#{item_cost}.\nHow much are you paying?"
#       @amount_paid = input.gets.chomp.to_f # notice that we call gets on that parameter
#       break if valid_payment? && sufficient_payment?
#       # puts 'That is not the correct amount. ' \
#       #      'Please make sure to pay the full cost.'
#     end
#   end
# end

class TransactionTest < Minitest::Test
  def test_prompt_for_payment   
    transaction = Transaction.new(30.0)

    string_stream_input = StringIO.new("30\n")
    string_stream_output = StringIO.new

    transaction.prompt_for_payment(input: string_stream_input, output: string_stream_output)
    
    assert_equal 30.0, transaction.amount_paid
  end
end
