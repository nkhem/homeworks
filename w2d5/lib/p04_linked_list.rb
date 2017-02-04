class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @next.prev = @prev
    @prev.next = @next
  end
end

class LinkedList
  include Enumerable
  attr_reader :head, :tail

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail && @tail.prev == @head
  end

  def get(key, current_link = @head)
    return current_link.val if current_link.key == key
    return nil if current_link == @tail
    get(key, current_link.next)
  end

  def include?(key)
    return true if self.get(key)
    false
  end

  def append(key, val) # (:first, 1)
    new_link = Link.new(key, val)
    prior_link = @tail.prev
    @tail.prev = new_link
    prior_link.next = new_link
    new_link.prev = prior_link
    new_link.next = @tail
  end

  def update(key, val, current_link = @head)
    return nil unless get(key)

    if current_link.key == key
      current_link.val = val
    else
      update(key, val, current_link.next)
    end
  end

  def remove(key, current_link = @head)
    return nil unless get(key)

    if current_link.key == key
      current_link.remove
    else
      remove(key, current_link.next)
    end
  end

  def each(current_link = first, &prc)
    return prc.call(current_link) if current_link == last
    prc.call(current_link) + each(current_link.next, &prc)
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
