# require_relative 'p02_hashing'

class HashSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count == num_buckets
    unless self.include?(num)
      self[num.hash] << num
      @count += 1
    end
  end

  def remove(num)
    self[num.hash].delete(num) if self.include?(num)
    @count -= 1
  end

  def include?(num)
    self[num.hash].include?(num)
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
