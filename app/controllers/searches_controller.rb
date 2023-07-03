class SearchesController < ApplicationController

  def search
    @range = params[:range]
    search = params[:seaech]
    word = params[:word]

    if @range == "1"
      @user = User.search(search,word)
    else
      @book = Book.search(search,word)
    end
  end

end
