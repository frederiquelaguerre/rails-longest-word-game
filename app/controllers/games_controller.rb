require "open-uri"
class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    # Le mot ne peut pas être créé à partir de la grille d’origine.
    @word = params[:word].upcase.split("")
    @grid = params[:grid]
    if !grid_agree(@word, @grid)
      @message = "Le mot : #{@word.join.upcase} ne peut pas être créé à partir de la grille d'origine."
    elsif !english(@word)
      @message = "Le mot : #{@word.join.upcase} est valide d'après la grille, mais ce n'est pas un mot anglais valide."
    else
      @message = "Le mot : #{@word.join.upcase} est valide d'après la grille et est un mot anglais valide."
    end
  end

  def english(word)
    url = "https://wagon-dictionary.herokuapp.com/#{@word.join}"
    word_serialized = URI.open(url).read
    word = JSON.parse(word_serialized)
    word["found"]
  end

  def grid_agree(word, grid)
    word.all? do |letter|
      word.count(letter) <= grid.count(letter)
    end
  end
end
