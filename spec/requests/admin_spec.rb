require 'rails_helper'

RSpec.describe "Admins", type: :request do
  describe "GET /unauthorized" do
    it "returns http success" do
      get "/admin/unauthorized"
      expect(response).to have_http_status(:success)
    end
  end

end
