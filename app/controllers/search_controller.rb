# frozen_string_literal: true

class SearchController < ApplicationController
  def show
    @place = params[:search_place]
    place = params[:search_place]
    method = params[:search_method]
    word = params[:search_word]
    @result = if place == 'place_book'
                Book.search(place, method, word)
              else
                User.search(place, method, word)
              end
  end
end
