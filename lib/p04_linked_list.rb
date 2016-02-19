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
end

class LinkedList
  include Enumerable

  def initialize
    @head = nil
    @tail = nil
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    @tail
  end

  def empty?
    @head.nil?
  end

  def get(key)
    return first unless first
    value = first.key
    node = first
    until value == key
      node = node.next
      return nil unless node
      value = node.key
    end
    node.val
  end

  def include?(key)
    included = false
    included = true if get(key)

    included
  end

  def insert(key, val)
    new_link = Link.new(key, val)
    new_link.prev = last
    if self.first
      new_link.prev.next = new_link
    else
      @head = new_link
    end
    @tail = new_link
  end

  def remove(key)
    return first unless first
    value = first.key
    node = first
    until value == key
      node = node.next
      return nil unless node
      value = node.key
    end
    node.prev.nil? ? @head = node.next : node.prev.next = node.next
    node.next.nil? ? @tail = node.prev : node.next.prev = node.prev
  end

  def each(&prc)
    prc ||= Proc.new { |val| val }
    node = first
    until node.nil?
      prc.call(node)
      node = node.next
    end

  end

  # uncomment when you have `each` working and `Enumerable` included
   def to_s
     inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
   end
end
