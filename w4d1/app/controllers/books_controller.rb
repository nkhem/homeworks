class BooksController < ApplicationController
  def index
    render json: Book.all
  end

  def new
    # your code here
  end

  def create
    book = Book.new(book_params)

    if book.save
      render json: book
    else
      render json: book.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    book = Book.find_by(id: params[:id])

    if book.destroy
      render json: book
    else
      render json: "Can't, too important to destroy"
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :author)
  end
end
