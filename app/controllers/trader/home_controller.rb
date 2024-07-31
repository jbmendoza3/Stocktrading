class Trader::HomeController < ApplicationController
  def index
    if current_user.creation_status == "pending"
      redirect_to pending_approval_path
    end
  end
end
