class Trader::TransactionsController < ApplicationController
  def index
    @user_transactions = current_user.transactions
  end

  def show
    @user_transaction = current_user.transactions.find(params[:id])
  end

  def new
  end
end
