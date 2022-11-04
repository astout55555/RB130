### Provided Todo class definition:

# This class represents a todo item and its associated
# data: name and description. There's also a "done"
# flag to show whether this todo item is done.

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title &&
      description == otherTodo.description &&
      done == otherTodo.done
  end
end

### TodoList class implementation (the assignment):

# This class represents a collection of Todo objects.
# You can perform typical collection-oriented actions
# on a TodoList object, including iteration and selection.

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  # rest of class needs implementation (my code added below)

  def add(todo)
    if todo.class == Todo
      @todos << todo
    else
      raise TypeError.new("Can only add Todo objects")
    end
  end

  # LS solution utilizes alias_method, I was unfamiliar but it's more succinct
  alias_method :<<, :add # I reversed it because I defined #add first

  # def <<(todo)
  #   add(todo)
  # end

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  # def to_a
  #   @todos
  # end

  # LS solution correctly returns a new array
  def to_a
    @todos.clone
  end

  def done?
    @todos.each do |todo|
      return false if !todo.done?
    end

    true
  end

  def item_at(index)
    @todos.fetch(index)
  end

  def mark_done_at(index)
    item_at(index).done!
  end

  def mark_undone_at(index)
    item_at(index).undone!
  end

  # I notice this is the same as #mark_all_done, could simply alias these methods
  def done!
    @todos.each do |todo|
      todo.done!
    end
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(index)
    item_at(index) # to trigger IndexError if invalid index
    @todos.delete_at(index)
  end

  # def to_s
  #   list = <<~LIST

  #     "---- #{title} ----"

  #   LIST

  #   @todos.each do |todo|
  #     list += todo.to_s
  #     list += "\n"
  #   end

  #   list
  # end

  # LS solution more concise, uses #map and #join
  def to_s
    text = "---- #{title} ----\n"
    text << @todos.map(&:to_s).join("\n")
    text
  end

  def each
    @todos.each do |todo|
      yield(todo)
    end
    self
  end

  def select
    selection = TodoList.new(title)

    @todos.each do |todo|
      selection << todo if yield(todo)
    end

    selection
  end

  def find_by_title(todo_title)
    each do |todo|
      return todo if todo.title == todo_title
    end

    nil
  end

  # LS solution uses #select, relying on the fact that first element is nil if empty
  # def find_by_title(title)
  #   select { |todo| todo.title == title }.first
  # end

  def all_done
    select { |todo| todo.done? }
  end

  def all_not_done
    select { |todo| !todo.done? }
  end

  def mark_done(todo_title)
    find_by_title(todo_title).done!
  end

  # LS solution returns a boolean based on whether item is found originally
  # if not found, will short circuit to return false without triggering error
  # (NoMethodError when calling #done! on nil). I think the error is useful, though.
  # def mark_done(title)
  #   find_by_title(title) && find_by_title(title).done!
  # end

  def mark_all_done
    each { |todo| todo.done! }
  end

  def mark_all_undone
    each { |todo| todo.undone! }
  end

  # added this at first for a test, then removed because not necessary
  # def ==(other_todolist)
  #   to_a == other_todolist.to_a
  # end
end

### Test cases/code below:

# given
# todo1 = Todo.new("Buy milk")
# todo2 = Todo.new("Clean room")
# todo3 = Todo.new("Go to gym")
# list = TodoList.new("Today's Todos")

# ---- Adding to the list -----

# add
# list.add(todo1)                 # adds todo1 to end of list, returns list
# list.add(todo2)                 # adds todo2 to end of list, returns list
# list.add(todo3)                 # adds todo3 to end of list, returns list
# list.add(1)                     # raises TypeError with message "Can only add Todo objects"

# <<
# same behavior as add

# ---- Interrogating the list -----

# size
# list.size                       # returns 3

# first
# list.first                      # returns todo1, which is the first item in the list

# last
# list.last                       # returns todo3, which is the last item in the list

#to_a
# list.to_a                      # returns an array of all items in the list

#done?
# list.done?                     # returns true if all todos in the list are done, otherwise false

# ---- Retrieving an item in the list ----

# item_at
# list.item_at                    # raises ArgumentError
# list.item_at(1)                 # returns 2nd item in list (zero based index)
# list.item_at(100)               # raises IndexError

# ---- Marking items in the list -----

# mark_done_at
# list.mark_done_at               # raises ArgumentError
# list.mark_done_at(1)            # marks the 2nd item as done
# list.mark_done_at(100)          # raises IndexError

# mark_undone_at
# list.mark_undone_at             # raises ArgumentError
# list.mark_undone_at(1)          # marks the 2nd item as not done,
# list.mark_undone_at(100)        # raises IndexError

# # done!
# list.done!                      # marks all items as done

# ---- Deleting from the list -----

# shift
# list.shift                      # removes and returns the first item in list

# pop
# list.pop                        # removes and returns the last item in list

# remove_at
# list.remove_at                  # raises ArgumentError
# list.remove_at(1)               # removes and returns the 2nd item
# list.remove_at(100)             # raises IndexError

# # ---- Outputting the list -----

# # to_s
# list.to_s                      # returns string representation of the list

# # ---- Today's Todos ----
# # [ ] Buy milk
# # [ ] Clean room
# # [ ] Go to gym

# # or, if any todos are done

# # ---- Today's Todos ----
# # [ ] Buy milk
# # [X] Clean room
# # [ ] Go to gym

## Test cases

# todo1 = Todo.new("Buy milk")
# todo2 = Todo.new("Clean room")
# todo3 = Todo.new("Go to gym")

# list = TodoList.new("Today's Todos")
# list.add(todo1)
# list.add(todo2)
# list.add(todo3)

# puts list

# list.pop

# puts list

# list.mark_done_at(1)

# puts list

### TodoList#each test cases:

# todo1 = Todo.new("Buy milk")
# todo2 = Todo.new("Clean room")
# todo3 = Todo.new("Go to gym")

# list = TodoList.new("Today's Todos")
# list.add(todo1)
# list.add(todo2)
# list.add(todo3)

# list.each do |todo|
#   puts todo                   # calls Todo#to_s
# end

# ### TodoList#select test cases:

# todo1 = Todo.new("Buy milk")
# todo2 = Todo.new("Clean room")
# todo3 = Todo.new("Go to gym")

# list = TodoList.new("Today's Todos")
# list.add(todo1)
# list.add(todo2)
# list.add(todo3)

# todo1.done!

# results = list.select { |todo| todo.done? }    # you need to implement this method

# puts results.inspect

# ### TodoList additional methods testing:

# list.find_by_title('Buy milk')

# p list.all_done
