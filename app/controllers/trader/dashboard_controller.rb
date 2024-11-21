class Trader::DashboardController < ApplicationController
  def index
    @trader = current_user
    @balance = current_user.balance
    #remove ^ by using local
  end
end
