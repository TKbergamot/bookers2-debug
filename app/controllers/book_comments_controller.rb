class BookCommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    @book_comment = BookComment.new(book_comment_params)
    @book_comment.user_id = current_user.id
    @book_comment.book_id = book.id
    if @book_comment.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    book = Book.find(params[:id])
  	@book_comment = book.book_comments.find(params[:book_id])
  	@book_comment.destroy
    redirect_back(fallback_location: root_path)
  end


  private
  def book_comment_params
    params.require(:book_comment).permit(:content)
  end
end