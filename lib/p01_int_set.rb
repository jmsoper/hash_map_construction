class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    if validate!(num)
      @store[num] = true
    end
  end

  def remove(num)
    if validate!(num)
      @store[num] = false
    end
  end

  def include?(num)
    if validate!(num)
      @store[num] == true
    end
  end

  private

  def is_valid?(num)
    num <= @store.size && num > -1
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
    true
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    bucket = num % num_buckets
    @store[bucket] << num
  end

  def remove(num)
    bucket = num % num_buckets
    @store[bucket].delete(num)
  end

  def include?(num)
    bucket = num % num_buckets
    bucket_array = @store[bucket]
    bucket_array.include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if count >= num_buckets
    bucket = num % num_buckets
    @store[bucket] << num
    @count += 1
  end

  def remove(num)
    bucket = num % num_buckets
    @store[bucket].delete(num)
    @count -= 1
  end

  def include?(num)
    bucket = num % num_buckets
    @store[bucket].include?(num)
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
    temp_array = []
    @store.each do |arr|
      arr.each do |val|
        temp_array << val
      end
    end
    @count = 0
    @store = new_array
    temp_array.each do |val|
      insert(val)
    end
  end
end
