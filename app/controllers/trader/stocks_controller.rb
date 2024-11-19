class Trader::StocksController < ApplicationController
  def index
    @stocks = current_user.stocks
  end

  def show
    @stock = current_user.stocks.find(params[:id])
  end

  def search

    if params[:symbol].present?
      api = AlphaVantageApi.new
      @stock_data = api.fetch_stock_data(params[:symbol])
    else
      flash[:alert] = "Failed to fetch stock data"
    end

  end
end
