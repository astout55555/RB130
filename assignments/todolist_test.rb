require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'todo_list'

class TodoListTest < MiniTest::Test

  def setup # 'S' from 'SEAT'
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  # first example test demonstrated for me:
  def test_to_a
    assert_equal(@todos, @list.to_a) # 'E' is `@list.to_a`; 'A' is `assert_equal`
  end
  # we don't have/need the 'T' (teardown) for this situation

  # Your tests go here. Remember they must start with "test_"

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    result = @list.shift
    assert_equal(@todo1, result)
    # assert_equal(2, @list.size) # to check for more than just size, LS solution below
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    returned = @list.pop
    assert_equal(@todo3, returned)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done?
    assert_equal(false, @list.done?)
  end

  def test_only_todo_objects
    assert_raises(TypeError) { @list << 'not a todo object' }
    assert_raises(TypeError) { @list << 7 }
  end

  def test_shovel
    some_todo = Todo.new('Do something')
    @list << some_todo
    assert_equal([@todo1, @todo2, @todo3, some_todo], @list.to_a)
  end

  # Alternate LS solution, compares the @list object and the @todos list:
  # def test_shovel
  #   new_todo = Todo.new("Walk the dog")
  #   @list << new_todo
  #   @todos << new_todo
  
  #   assert_equal(@todos, @list.to_a)
  # end

  def test_add_alias
    new_todo = Todo.new("Walk the dog")
    @list << new_todo
    @todos << new_todo
  
    assert_equal(@todos, @list.to_a)
  end

  def test_item_at
    assert_raises(IndexError) { @list.item_at(20) }
    assert_equal(@todo2, @list.item_at(1))
    assert_equal(@todo3, @list.item_at(2))
  end

  def test_mark_done_at
    @list.mark_done_at(2)
    assert(@list.item_at(2).done?)
    assert_equal(false, @todo1.done?)
    assert_raises(IndexError) { @list.mark_done_at(7) }
  end

  def test_mark_undone_at
    @list.mark_done_at(1)
    assert(@todo2.done?)
    @list.mark_undone_at(1)
    assert_equal(false, @todo2.done?)
    assert_equal(false, @todo1.done?)
    assert_raises(IndexError) { @list.mark_undone_at(5) }
  end

  def test_done!
    @list.done!
    assert(@todo1.done?)
    assert(@todo2.done?)
    assert(@todo3.done?)
    assert(@list.done?)
  end

  def test_remove_at
    assert_raises(IndexError) { @list.remove_at(7) }
    returned = @list.remove_at(1)
    assert(returned == @todo2)
    assert_equal([@todo1, @todo3], @list.to_a)
  end

  def test_to_s
    output = <<~OUTPUT.chomp
      ---- Today's Todos ----
      [ ] Buy milk
      [ ] Clean room
      [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s_2
    output = <<~OUTPUT.chomp
      ---- Today's Todos ----
      [ ] Buy milk
      [ ] Clean room
      [X] Go to gym
    OUTPUT

    @list.mark_done_at(2)
    assert_equal(output, @list.to_s)
  end

  def test_to_s_3
    output = <<~OUTPUT.chomp
      ---- Today's Todos ----
      [X] Buy milk
      [X] Clean room
      [X] Go to gym
    OUTPUT

    @list.done!
    assert_equal(output, @list.to_s)
  end

  def test_each
    @list.each do |todo|
      todo.done!
    end

    assert(@list.done?)
  end

  def test_each_returns_original_list
    returned = @list.each { |_| nil }
    assert_equal(@list, returned)
  end

  # LS solution puts execution in same line as assertion:
  # def test_each_returns_original_list
  #   assert_equal(@list, @list.each {|todo| nil })
  # end

  # I used the below code, but it required that I add a TodoList#== method
  # def test_select
  #   @list.mark_done_at(1)
  #   new_list = TodoList.new('test list')
  #   new_list << @todo2
  #   assert_equal(new_list, @list.select { |todo| todo.done? })
  # end

  # instead, this LS solution works without changing the source code
  # can compare relevant details here to ensure TodoList#select is working
  # without committing to a particular implementation of a TodoList#== method
  def test_select
    @todo1.done!
    list = TodoList.new(@list.title)
    list.add(@todo1)
  
    assert_equal(list.title, @list.title)
    assert_equal(list.to_s, @list.select{ |todo| todo.done? }.to_s)
  end
end
