class HangpersonGame

  # cd ..\..\..\..\Desktop\Spring19\CS169\Homework\hw-sinatra-saas-hangperson
  # bundle exec autotest
  # bundle exec rackup

  attr_reader :word, :guesses, :wrong_guesses
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    # letter = letter.to_s.downcase
    # @word.any?{|l| l.casecmp(letter)==0}
    # if @word.include? letter and not @guesses.include? letter


    if letter == nil or not (letter.class == String && letter =~ /^[A-z]$/i)
      raise ArgumentError
    end

    letter.downcase!

    if @guesses.include? letter or @wrong_guesses.include? letter or letter.length != 1
      return false
    end

    if @word.include? letter
      @guesses << letter
    else
      @wrong_guesses << letter
    end
    return true

=begin
    if @word.to_s.include? letter.to_s.downcase and not @guesses.to_s.include? letter.to_s.downcase
      @guesses += letter
      # puts guesses
    # elsif not @word.include? letter
    elsif not @word.to_s.downcase.include? letter.to_s.downcase
      if not @wrong_guesses.to_s.downcase.include? letter.to_s.downcase
      # if not @wrong_guesses.include? letter
        @wrong_guesses += letter
        # puts wrong_guesses
      end
    end
=end
  end



  def word_with_guesses
    result = ''
    @word.split('').each do |char|
      if @guesses.include? char
        result << char
      else
        result << '-'
      end
    end

    return result
  end


  def check_win_or_lose
    if word_with_guesses == @word
      return :win
    elsif @wrong_guesses.length >= 7
      return :lose
    else
      return :play
    end

  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
