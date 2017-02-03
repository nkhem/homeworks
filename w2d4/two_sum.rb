def bad_two_sum?(arr, target_sum)
  arr.length.times do |i1|
    arr.length.times do |i2|
      return true if arr[i1] + arr[i2] == target_sum
    end
  end

  false
end #=>n^2

def okay_two_sum?(arr, target_sum)
  arr2 = arr.map{|x| target_sum - x} # => n

  arr2.each_with_index do |desired_num, i2| #=> n^2
    if arr.include?(desired_num) && arr.index(desired_num) != i2
      return true
    end
  end

  false
end #=> n^2

def hash_two_sum?(arr, target_sum)
  hash = Hash.new(0)
  arr.each do |num|
    hash[num] += 1
  end

  arr2 = arr.map{|x| target_sum - x}

  arr2.each do |num|
    return true if hash[num] > 0
  end
  return false
end

def sorting_two_sum?(arr, target_sum)
  arr2 = arr.map{|x| target_sum - x} # => n

  arr2.each_with_index do |desired_num, i2| #=> n
    if arr.bsearch(desired_num) != i2 #=> log n
      return true
    end
  end #=> n log n

  false

end #=> n + n log n ==> n log n

def bsearch(arr, target)
  mid = arr.length / 2
  return nil if arr.empty?
  return mid if arr[mid] == target

  if target < arr[mid]
    bsearch(arr[0...mid], target)
  else
    bsearch(arr[(mid + 1)..-1], target)
  end

end

def bsearch(arr, target, rollover = 0)
  mid = arr.length / 2
  return nil if arr.empty?
  return mid + rollover if arr[mid] == target

  if target < arr[mid]
    bsearch(arr[0...mid], target, rollover)
  else
    bsearch(arr[(mid + 1)..-1], target, mid + rollover)
  end

end

def okay_two_sum?(arr, target_sum)
  arr2 = arr.map{|x| target_sum - x} # => n

  arr2.each_with_index do |desired_num, i2| #=> n
    if arr.include?(desired_num) && arr.index(desired_num) != i2 #=> n
      return true
    end
  end #=> n^2

  false
end #=> n + n^2 ==> n^2
