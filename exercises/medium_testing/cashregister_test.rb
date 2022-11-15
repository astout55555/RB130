require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < Minitest::Test
  def setup
    @cash_register = CashRegister.new(100.00)
  end
  
  def test_accept_money
    transaction = Transaction.new(50.00)
    transaction.amount_paid = 50.00

    previous_amount = @cash_register.total_money
    @cash_register.accept_money(transaction)
    current_amount = @cash_register.total_money
    
    assert_equal previous_amount + 50.00, current_amount
  end # using vars for before and after values for clarity

  def test_change
    transaction = Transaction.new(30.00)
    transaction.amount_paid = 40.00

    difference = transaction.amount_paid - transaction.item_cost

    assert_equal difference, @cash_register.change(transaction)
  end

  def test_give_receipt
    transaction = Transaction.new(20.0)

    expected_receipt = <<~RECEIPT
      You've paid $20.0.
    RECEIPT

    assert_output(expected_receipt, nil) do
      @cash_register.give_receipt(transaction)
    end
  end
end