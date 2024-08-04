class StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :check_pending_approval, only: [:index]

  def index
    @stocks = Stock.all
  end

  def add
    @stock = Stock.find(params[:id])
    current_user.stocks << @stock unless current_user.stocks.include?(@stock)
    redirect_to user_stocks_portfolio_path, notice: "#{@stock.name} was added to your portfolio."
  end

  private
  
  def check_pending_approval
    if current_user.user_type == 'trader' && current_user.creation_status == 'pending'
      redirect_to pending_approval_path, alert: 'Your account is pending approval. Please wait until your account is approved to access the stock list.'
    end
  end
end
