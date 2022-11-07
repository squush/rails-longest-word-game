require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    letters = 'AAAAAAAAABBCCDDDDEEEEEEEEEEEEFFGGGHHIIIIIIIIIJKLLLLMMNNNNNNOOOOOOOOPPQRRRRRRSSSSTTTTTTUUUUVVWWXYYZ'.chars
    @letters = letters.sample(9)
  end

  def score
    @word = params[:word].upcase
    @points = @word.length * @word.length
    @result = "Congrats! You scored #{@points} points."

    letters = params[:letters].split(" ")

    response = URI.open("https://wagon-dictionary.herokuapp.com/#{@word}")
    json = JSON.parse(response.read)




    @word.chars.each do |letter|
      if letters.include?(letter)
        letters.delete_at(letters.index(letter))
      else
        @result = "word not found in grid letters"
      end
    end

    @result = "not a valid word" if json["found"] === false
  end

  def all_scores
    @scores = []
    @scores << session[:points]
  end
end
