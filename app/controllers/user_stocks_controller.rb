class UserStocksController < ApplicationController
  before_action :authenticate_user!

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
end
