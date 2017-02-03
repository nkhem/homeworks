def anagram?(word1, word2)

  word1_anagrams = word1.chars.permutation.to_a.map(&:join)
  word1_anagrams.include?(word2)

end #=> n!

def anagram2?(word1, word2)
  return false if word1.length != word2.length

  new_word_1 = word1.dup.chars.reject do |char| #=> n
    word2.chars.include?(char) #=> n
  end

  new_word_1.empty?
end #=> n^2

def anagram3?(word1, word2)
  word1.chars.sort.join == word2.chars.sort.join #=> 2n^2 + 2n => n^2
end

def anagram4?(word1, word2)
  word1_hash = Hash.new(0)
  word2_hash = Hash.new(0)

  word1.split("").each do |char|
    word1_hash[char] += 1
  end

  word2.split("").each do |char|
    word2_hash[char] += 1
  end

  word1_hash == word2_hash
end #=>n

def anagram5?(word1, word2)
  hash = Hash.new(0)

  word1.split("").each do |char|
    hash[char] += 1
  end #=> n

  hash.each do |char, val|
    return false unless word2.split("").count(char) == val
  end #=> n^2

  true
end #=> n^2
