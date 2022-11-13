require 'minitest/autorun'

require 'minitest/reporters'

MiniTest::Reporters.use!

class Candidate
  def initialize
    @experience = 0
  end
  
  def hire
    raise NoExperienceError unless @experience > 0
  end
end

class NoExperienceError < StandardError
  def initialize
    super
    @message = 'Candidate has no experience.'
  end
end

class List
  def initialize(contents)
    @contents = Array.new(contents)
  end

  def process
    self
  end
end

class Easy_Tests < MiniTest::Test
  def test_boolean
    value = 3
    assert value.odd?, 'value is not odd'
    assert_equal true, value.odd? # preferred since specifically expecting `true`
  end

  def test_equality
    value = 'XYZ'
    assert_equal 'xyz', value.downcase
  end

  def test_nil
    value = nil
    # assert_equal nil, value
    assert_nil value # preferred when expecting `nil`, #assert_equal is deprecated for nil
  end

  def test_empty
    list = []
    assert_equal true, list.empty?
    assert_empty list # preferred for better failure message when expecting `true`
  end

  def test_included
    list = [1, 'xyz', 3]
    assert_includes list, 'xyz' # assert_equal could be used too, but less clear
  end

  def test_exception
    employee = Candidate.new
    assert_raises(NoExperienceError) do
      employee.hire
    end
  end

  def test_type
    value = Numeric.new
    assert_instance_of(Numeric, value)
  end

  def test_kind
    value = 2.0
    assert_equal true, value.is_a?(Numeric)
    assert_kind_of Numeric, value # preferred assertion
  end

  def test_same_object
    list = List.new([1, 2, 3])
    assert_same list, list.process
  end

  def test_refute
    list = [1, 2, 3]
    refute(list.include?('xyz'))
    refute_includes list, 'xyz' # preferred, although assertions preferred over refutations
  end
end
