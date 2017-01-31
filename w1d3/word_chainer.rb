require "byebug"
class WordChainer
  ALPHABET = ("a".."z").to_a

  attr_reader :rem_words, :goal, :start_word, :current_word, :used_words, :current_path
  def initialize(start_word, goal, filename = 'dictionary.txt')
    @rem_words = File.readlines(filename).map(&:chomp)
    @used_words =[]
    @current_path = []
    @start_word = start_word
    @goal = goal
  end

  def play
    same_length_words!(@start_word)
    @current_word = @start_word
    until @current_word == @goal
      @current_path << @current_word
      p @current_word
      test_match = round
      if test_match == nil && @current_path.length == 1
        return "Try another set of words"
      elsif test_match == nil
        @current_path.pop
        @current_word = @current_path.last
      else
        @current_word = test_match
      end
    end

     @current_path << @goal
  end

  def round
    adj_words = adjacent_words(@current_word)
    @used_words << @current_word
    best_match(adj_words)
  end

  def adjacent_words(word)
    adj_words = []

    word.chars.each_with_index do |char, idx|
      ALPHABET.each do |letter|
        new_word = replace_letter(word, idx, letter)
        if @rem_words.include?(new_word) && !adj_words.include?(new_word) && !@used_words.include?(new_word)
          adj_words << new_word
        end
      end
    end

    adj_words.delete(word)
    adj_words
  end

  def best_match(arr)
    return nil if arr.empty?
    best_count = num_matching_letters(arr[0], @goal)
    best_match = arr[0]
    arr.each do |test_word|
      current_count = num_matching_letters(test_word, @goal)
      if current_count > best_count
        best_count = current_count
        best_match = test_word
      end
    end
    best_match
  end



  def replace_letter(word, idx, letter)
    word[0...idx] + letter + word [(idx + 1)..-1]
  end

  def same_length_words!(word)
    @rem_words = @rem_words.select{|x| x.length == word.length}
  end

  def num_matching_letters(word1, word2)
    counter = 0
    word1.chars.each_with_index do |char, idx|
      counter +=1 if char == word2[idx]
    end
    counter
  end


end
