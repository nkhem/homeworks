def my_min_ii(arr)
  min = arr.first

  arr.each do |el1|
    min = el1 if el1 < min
  end

  min
end

def my_min_i(arr)

  arr.each do |el1|
    is_min = true

    arr.each do |el2|
      is_min = false if el1 > el2
    end

    return el1 if is_min
  end

end

def largest_contiguous_subsum(arr)
  all_subarrays = []

  arr.length.times do |i1| #n
    arr.length.times do |i2| #n
      if i1 <= i2
        subarr = arr[i1..i2] #n
        all_subarrays << subarr unless all_subarrays.include?(subarr) # n + 1
      end
    end
  end # => n^3

  all_subarrays.map do |arr|
     arr.inject(:+)
  end.max # n + (n-1) + (n-2) ... 1 =>n
end #=> n^3


def largest_contiguous_subsum2(arr)
  running_sum = 0
  highest_score = arr[0]

  arr.each do |el|
    if el + running_sum < 0
      running_sum = 0
      highest_score = running_sum if running_sum > highest_score
    else
      running_sum += el
    end
  end
end
