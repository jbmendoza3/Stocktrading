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
    user_stock = current_user.user_stocks.find_or_initialize_by(stock: stock)

    if stock.price <= current_user.balance
      current_user.balance -= stock.price
      user_stock.quantity += 1
      user_stock.save
      current_user.save
      redirect_to portfolio_user_stocks_path, notice: "Successfully bought 1 share of #{stock.name}."
    else
      redirect_to portfolio_user_stocks_path, notice: "You don't have enough balance to buy this stock."
    end
  end

  def sell
    stock = Stock.find(params[:stock_id])
    user_stock = current_user.user_stocks.find_by(stock: stock)
    
    if user_stock && user_stock.quantity > 0
      current_user.balance += stock.price
      user_stock.quantity -= 1
      user_stock.save
      current_user.save
      redirect_to portfolio_user_stocks_path, notice: "Successfully sold 1 share of #{stock.name}."
    else
      redirect_to portfolio_user_stocks_path, alert: "You don't have any shares of #{stock.name} to sell."
    end
  end


  private

  def check_pending_approval
    if current_user.user_type == 'trader' && current_user.creation_status == 'pending'
      redirect_to pending_approval_path, alert: 'Your account is pending approval. Please wait until your account is approved to access the stock list.'
    end
  end
end
