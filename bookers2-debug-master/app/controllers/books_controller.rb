class BooksController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_book,only: [:edit]

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @books = Book.new
  end

  def index
    @book = Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)

    @book.user = current_user
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

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def correct_book
    @book = Book.find(params[:id])
    @user = @book.user
    unless current_user == @user
      redirect_to books_path(@books)
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
