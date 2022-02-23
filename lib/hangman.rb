class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]
  
  def self.random_word 
    DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    if self.attempted_chars.include?(char)
      return true
    end 

    false
  end

  def get_matching_indices(char)
    indices_where_char_in_word = []
    secret_word_in_array = @secret_word.split("")
    (0..secret_word_in_array.length-1).each do |index|
      if char == secret_word_in_array[index]
        indices_where_char_in_word << index
      end
    end
    indices_where_char_in_word
  end

  def fill_indices(char, array)
    (0..@guess_word.length-1).each do |index|
      if array.include?(index)
        @guess_word[index] = char
      end
    end
  end

  def try_guess(char)
    if self.already_attempted?(char)
      puts "that has already been attempted"
      return false
    end

    @attempted_chars << char
    @remaining_incorrect_guesses -= 1 if self.get_matching_indices(char).empty?
    self.fill_indices(char, self.get_matching_indices(char))    
    
    true
  end

  def ask_user_for_guess
    puts "Enter a char:"
    char = gets.chomp
    return self.try_guess(char)
  end

  def win?
    if @guess_word.join("") == @secret_word
      puts "WIN"
      return true
    end 

    false
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      puts "LOSE"
      return true
    end

   false
  end

  def game_over?
    win = self.win?
    lose = self.lose?

    if win || lose
      puts @secret_word
      return true
    end

    false
  end

end
