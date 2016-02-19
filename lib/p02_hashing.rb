class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    if self.length < 2
      hash_value = self[0].hash
    elsif self.length < 3
      hash_value_1 = self[0].hash
      hash_value_2 = self[1].hash

      hash_value =  hash_value_1 ^ hash_value_2
    else
      mid_index = self.size/2
      front = take(mid_index)
      back = drop(mid_index)
      hash_value = front.hash - back.hash
    end
    return hash_value
  end
end


class String
  def hash
    letters = self.split(//)
    letters.map!(&:ord)
    letters.hash
  end
end

class Hash
  def hash
    keys = self.keys.sort
    values = self.values.sort
    keys.hash ^ values.hash
  end
end
