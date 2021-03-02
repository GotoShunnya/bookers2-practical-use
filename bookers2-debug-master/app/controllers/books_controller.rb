class BooksController < ApplicationController

  def show
    @user = User.find(params[:id])
    @book = @user.books
  end

  def index
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book = current_user
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def delete
    @book = Book.find(params[:id])
    @book.destoy
    redirect_to books_path
  end

  private

  def book_params
    params.permit(:title, :body)
  end

end
