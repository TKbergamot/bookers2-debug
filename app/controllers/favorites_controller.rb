# frozen_string_literal: true

class FavoritesController < ApplicationController
  before_action :set_book

  def create
    @favorite = current_user.favorites.create(book_id: params[:book_id])
  end

  def destroy
    @favorite = Favorite.find_by(book_id: params[:book_id], user_id: current_user.id)
    @favorite.destroy
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end
end
