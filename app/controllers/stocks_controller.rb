class StocksController < ApplicationController
  before_action :authenticate_user!

  def index
    @stocks = Stock.all
  end

  def add
    @stock = Stock.find(params[:id])
    current_user.stocks << @stock unless current_user.stocks.include?(@stock)
    redirect_to user_stocks_portfolio_path, notice: "#{@stock.name} was added to your portfolio."
  end
end
