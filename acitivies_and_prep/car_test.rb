require 'minitest/autorun'

require_relative 'car'

class CarTest < MiniTest::Test
  def setup
    @car = Car.new
  end

  def test_car_exists
    assert(@car)
  end

  def test_wheels
    assert_equal(4, @car.wheels)
  end

  def test_name_is_nil
    assert_nil(@car.name)
  end

  def test_raise_initialize_with_arg
    assert_raises(ArgumentError) do
      Car.new(name: "Joey")
    end
  end

  def test_instance_of_car
    assert_instance_of(Car, @car)
  end

  def test_includes_car
    arr = [1, 2, 3]
    arr << @car

    assert_includes(arr, @car)
  end
end

# Assertion style syntax, looks like regular Ruby code
# (not a "Domain Specific Language" - DSL - like what RSpec uses)

# SEAT:
# Setup (#setup instance method runs before every test)
# Execute code (always necessary)
# Assert results (always necessary)
# Teardown (#teardown instance method runs after every test)
