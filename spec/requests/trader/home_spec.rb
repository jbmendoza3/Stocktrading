require 'rails_helper'

RSpec.describe "Trader::Homes", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/trader/home/index"
      expect(response).to have_http_status(:success)
    end
  end

end
