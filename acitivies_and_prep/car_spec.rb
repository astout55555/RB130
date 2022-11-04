require 'minitest/autorun'

require_relative 'car'

describe 'Car#wheels' do
  it 'has 4 wheels' do
    car = Car.new
    _(car.wheels).must_equal 4 # this is the expectation
  end
end

# Expectation style syntax, more closely mimics RSpec's syntax
# LS will stick with "assertion style" syntax, which looks more like normal Ruby
