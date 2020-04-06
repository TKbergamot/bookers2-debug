# frozen_string_literal: true
class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @book_comments = @book.book_comments
    @book_comment = @book.book_comments.new(book_comment_params)
    @book_comment.user_id = current_user.id
    if @book_comment.save
    else
      flash.now[:alert] = 'Failed to comment.'
      render :show
    end

  end
  def destroy
    @book = Book.find(params[:book_id])
    @book_comments = @book.book_comments
    book_comment = BookComment.find(params[:id])
    book_comment.destroy
  end


  private
  def book_comment_params

    params.permit(:content)

  end

end
