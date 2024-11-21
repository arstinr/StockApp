class Admin::TradersController < ApplicationController
  def index
    @traders = User.traders
  end

  def show
    @trader = User.traders.find(params[:id])
  end

  def new
    @trader = User.new
  end

  def create
    @trader = User.new(trader_params)
    @trader.skip_confirmation! #SKIP CONFIRMABLE????

    if @trader.save
      redirect_to admin_traders_path, notice: "Trader account succesfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @trader = User.traders.find(params[:id])
  end

  def update
    @trader = User.traders.find(params[:id])
    
    if @trader.update(trader_params)
      redirect_to admin_traders_path, notice: "Trader account succesfully created!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def pending
    @pending_traders = User.pending
  end

  def approve
    @trader = User.traders.find(params[:id])
  
    if @trader.update(is_approved: true)
      UserMailer.approval_email(@trader).deliver_now

      @trader.update(balance: 10000)

      redirect_to admin_traders_path, notice: "Trader approved successfully!"
    else
      redirect_to admin_traders_path, alert: "Failed to approve trader. Please try again."
    end
  end
  

  private
    def trader_params
      params.require(:user).permit(:email, :name, :password, :is_approved)
    end
end
