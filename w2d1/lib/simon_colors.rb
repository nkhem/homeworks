require 'colorize'

class Simon
  COLORS = [
    "red".red,
    "blue".blue,
    "green".green,
    "yellow".yellow
  ]

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @seq = []
    @sequence_length = 1
    @game_over = false
  end

  def play
    until game_over
      take_turn
    end
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence
    round_success_message unless @game_over
    @sequence_length += 1
  end

  def show_sequence
    add_random_color
    puts @seq
    sleep(2)
    system 'clear'
  end

  def require_sequence
    puts "what'd ya see? Divided by commas"
    guess = gets.chomp.split(", ")
    if wrong_guess?(guess)
      @game_over = true
    end
  end

  def wrong_guess?(guess)
    return true unless @seq.length == guess.length
    @seq.each_with_index do |seq_color, seq_i|
      guess.each_with_index do |guess_color, guess_i|
        return true if seq_i == guess_i && !seq_color.match(guess_color)
      end
    end
    false
  end

  def add_random_color
    @seq << COLORS.sample
  end

  def round_success_message
    puts "Ya! Go you!"
  end

  def game_over_message
    puts "womp womp"
  end

  def reset_game
    @seq = []
    @sequence_length = 1
    @game_over = false
  end
end
