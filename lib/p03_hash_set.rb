require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if count >= num_buckets
    bucket = key.hash % num_buckets
    @store[bucket] << key
    @count += 1
  end

  def include?(key)
    bucket = key.hash % num_buckets
    @store[bucket].include?(key)
  end

  def remove(key)
    bucket = key.hash % num_buckets
    @store[bucket].delete(key)
    @count -= 1
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_array = Array.new(num_buckets * 2) { Array.new }

    temp_array = @store.flatten
    @store = new_array
    @count = 0
    temp_array.each do |val|
      self.insert(val)
    end
  end
end
