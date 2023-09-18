class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  attr_reader :word
  attr_reader :guesses
  attr_reader :wrong_guesses

  # Assisted by GitHub Copilot
  def guess(letter)
    # Test if input is valid
    if letter == nil || letter == '' || letter =~ /[^a-zA-Z]/
      raise ArgumentError
    end
    letter = letter.downcase

    # Test if it is a previous guess
    if @guesses.include?(letter) || @wrong_guesses.include?(letter)
      # return false if it is a previous guess
      return false
    end

    # Test if it is a correct guess
    if @word.include?(letter)
      # update @guesses
      @guesses += letter
    else
      # update @wrong_guesses
      @wrong_guesses += letter
    end

    # return true if it is a new guess
    return true
  end

  def word_with_guesses
    # Assisted by GitHub Copilot

    # return word with guessed letters
    # when guesses is '' it will return '-' * word.length
    if @guesses == ''
      return '-' * @word.length
    else
      return @word.gsub(/[^#{@guesses}]/, '-')
    end

  end


  def check_win_or_lose
    # Assisted by GitHub Copilot

    # return :win if word is guessed
    if @word == word_with_guesses
      return :win
    end

    # return :lose if wrong_guesses.length == 7
    if @wrong_guesses.length == 7
      return :lose
    end

    # return :play if word is not guessed and wrong_guesses.length < 7
    return :play
  end


  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
