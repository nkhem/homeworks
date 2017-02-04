class MaxIntSet
  attr_reader :max
  attr_accessor :store

  def initialize(max)
    @store = Array.new((max + 1), false)
    @max = max
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num >= 0 && num <= @max
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  attr_accessor :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num unless self.include?(num)
  end

  def remove(num)
    self[num].delete(num) if self.include?(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[ num.abs % num_buckets ]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :starting_buckets, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count == num_buckets
    unless self.include?(num)
      self[num] << num
      @count += 1
    end
  end

  def remove(num)
    self[num].delete(num) if self.include?(num)
    @count -= 1
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[ num.abs % num_buckets ]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  require 'byebug'

  def resize!
    prev_num_buckets = num_buckets
    new_store = Array.new(prev_num_buckets * 2) { Array.new }

    @store.each do |bucket|
      bucket.each do |el|
        new_store[ el.abs % (prev_num_buckets * 2) ] << el
      end
    end

    @store = new_store
  end

end

# O(n/20) => O(n)
# O(n/n) => O(n/20 * 1/n)
