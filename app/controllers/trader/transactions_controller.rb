class Trader::TransactionsController < ApplicationController
  def index
    @user_transactions = current_user.transactions
  end

  def show
  end

  def new
  end
end
