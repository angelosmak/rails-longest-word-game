require "open-uri"
class GamesController < ApplicationController

  def score
    @letters = params[:letters].split(" ")
    @word = params[:word].upcase
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    user_serialized = URI.open(url).read
    @user = JSON.parse(user_serialized)
    @found = @user["found"]
    @include = include?(@word, @letters)
  end

  def new
    @letters = ("A".."Z").to_a.sample(10)
  end

  private

  def include?(word, letters)
    word_chars = word.chars
    letters_chars = letters.map(&:upcase)

    word_chars.all? { |char| letters_chars.include?(char) }
  end

end
