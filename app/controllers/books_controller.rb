class BooksController < ApplicationController
  def sold
    @book = Book.find(params[:id])
    @book.sold!
    redirect_to :back
  end

  def edit
  end

  def update
  end

  def new
  end

  def create
  end
end
