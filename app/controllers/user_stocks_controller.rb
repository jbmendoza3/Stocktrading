class UserStocksController < ApplicationController
  before_action :authenticate_user!
  before_action :check_pending_approval, only: [:portfolio, :create]

  def create
    stock = Stock.find(params[:stock_id])
    
    if current_user.stocks.include?(stock)
      redirect_to stocks_path, alert: 'Stock already in your portfolio.'
    else
      current_user.stocks << stock
      redirect_to user_stocks_path, notice: 'Stock was successfully added to your portfolio.'
    end
  end

  def portfolio
    @stocks = current_user.stocks
  end

  def buy
    stock = Stock.find(params[:stock_id])
    
  end

  private

  def check_pending_approval
    if current_user.user_type == 'trader' && current_user.creation_status == 'pending'
      redirect_to pending_approval_path, alert: 'Your account is pending approval. Please wait until your account is approved to access the stock list.'
    end
  end
end
