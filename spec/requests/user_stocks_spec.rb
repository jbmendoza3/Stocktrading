require 'rails_helper'

RSpec.describe "UserStocks", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/user_stocks/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /portfolio" do
    it "returns http success" do
      get "/user_stocks/portfolio"
      expect(response).to have_http_status(:success)
    end
  end

end
