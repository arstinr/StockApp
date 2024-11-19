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
      @stock_symbol = @stock_data['Meta Data']['2. Symbol']
      @last_open_price = @stock_data['Time Series (5min)'].values.first.dig('1. open')
    else
      flash[:alert] = "Failed to fetch stock data"
    end
  end

end
