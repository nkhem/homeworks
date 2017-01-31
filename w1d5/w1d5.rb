# Exercise 1 - Stack
# Let's write a Stack class. To do this, use the following framework:

class Stack
    attr_reader :stack

    def initialize
      # create a var to store stack here!
      @stack = []
    end

    def add(el)
      # adds an element to the stack
      @stack << el
    end

    def remove
      # removes one element from the stack
      @stack.pop
    end

    def show
      # return a copy of the stack
      p @stack
    end
  end

# To test that your code works, create a new instance of the Stack class,
# and play around with adding and removing elements. Remember, a stack
# follows the principle of LIFO!
#
# Exercise 2 - Queue

# Now let's write a Queue class. We will need the following instance
# methods: enqueue(el), dequeue, and show.

class Queue
    attr_reader :queue

    def initialize
      @queue = []
    end

    def add(el)
      @queue << el
    end

    def remove
      @queue.shift
    end

    def show
      p @queue
    end
  end

# Test your code to ensure it follows the principle of FIFO.

# Exercise 3 - Map

# As you saw in the videos for tonight, a map can be implemented using a
# 2D array. Let's write a Map class (following a similar pattern to Stack
# and Queue) that implements a map using only arrays.
#
# Remember, a map stores information in key-value pairs, where the keys
# are always unique. When implemented with arrays, a map might look
# something like this: my_map = [[k1, v1], [k2, v2], [k3, v2], ...].
#
# Our Map class should have the following instance methods: assign(key,
# value), lookup(key), remove(key), show. Note that the assign method can
# be used to either create a new key-value pair or update the value for a
# pre-existing key. It's up to you to check whether a key currently
# exists!
#
class Map
    attr_reader :map

    def initialize
      @map = []
    end

    def assign(key, new_value)
      if key_exists?(key)
        reassign(key, new_value)
      else
        @map << [key, new_value]
      end
    end

    def reassign(key, new_value)
      @map.map do |pair|
        k, v = pair
        v = new_value if key == k
        [k, v]
      end
    end

    def key_exists?(key)
      @map.any? do |pair|
        k, v = pair
        key == k
      end
    end

    def idx_of_key_pair(key)
      @map.each_with_index do |pair, idx|
        k, v = pair
        return idx if key == k
      end
    end

    def remove(key)
      key_idx = idx_of_key_pair(key)
      @map = @map.take(key_idx) + @map.drop(key_idx + 1)
    end

    def show
      p @map
    end

  end

# As always, test your code thoroughly to make sure all properties of
# maps are enforced.
