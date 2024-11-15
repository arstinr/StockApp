class Trader::DashboardController < ApplicationController
  def index
    @trader = current_user
  end
end
