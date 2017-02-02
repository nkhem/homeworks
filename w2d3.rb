def sluggish_octopus(fishies)

  fishies.each_with_index do |fish1, i1|
    biggest = true

    fishies.each_with_index do |fish2, i2|
      biggest = false if fish2.length > fish1.length
    end

    return fish1 if biggest
  end

end

def dominant_octopus(fishies)
  prc = Proc.new{ |fish1, fish2| fish1.length <=> fish2.length}
  fishies.merge_sort(&prc).last
end

class Array

  def merge_sort(&prc)
    prc ||= Proc.new { |x, y| x <=> y }
    return self if self.count <= 1

    midx = self.length / 2
    left = self.take(midx).merge_sort(&prc)
    right = self.drop(midx).merge_sort(&prc)

    left.merge(right, &prc)
  end

  def merge(arr2, &prc)
    res = []
    arr1 = self.dup
    until arr1.empty? || arr2.empty?
      res << (prc.call(arr1[0], arr2[0]) == 1 ? arr2.shift : arr1.shift)
    end
    res + arr1 + arr2
  end
end


def clever_octopus(fishies)
  biggest = fishies.shift

  fishies.each do |fish|
    biggest = fish if fish.length > biggest.length
  end

  fish
end

def slow_dance(direction, tiles_array = nil)
  tiles_array ||= [
    "up",
    "right-up",
    "right",
    "right-down",
    "down",
    "left-down",
    "left",
    "left-up"
  ]

  tiles_array.each_with_index do |tile, i|
    return i if direction == tile
  end
end

def fast_dance(direction, tiles_hash = nil)
  tiles_hash ||= {
      "up" => 0,
      "right-up" => 1,
      "right"=> 2,
      "right-down" => 3,
      "down" => 4,
      "left-down" => 5,
      "left" => 6,
      "left-up" => 7
  }

  tiles_hash[direction]
end
