class Trader::StocksController < ApplicationController
  def index
    @stocks = current_user.stocks
  end
  
  def show
    @stock = current_user.stocks.find(params[:id])
  end

  def search
  end
end
