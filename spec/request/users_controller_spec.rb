require 'rails_helper'

RSpec.describe Admin::UsersController, type: :request do
  let(:admin) { create(:user, email: "admin@example.com", password: "password", user_type: :admin, creation_status: :approved) }
  let(:trader) { create(:user, email: "trader@example.com", password: "password", user_type: :trader, creation_status: :approved) }

  before do
    sign_in admin
  end

  describe "GET /admin/users" do
    it "returns a list of all users" do
      get admin_users_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include(admin.email)
      # expect(response.body).to include(trader.email)
    end
  end

  describe "GET /admin/users/:id" do
    it "returns the details of a specific user" do
      get admin_user_path(trader)
      expect(response).to have_http_status(:success)
      expect(response.body).to include(trader.email)
      expect(response.body).to include("User Type:")
    end
  end

  describe "POST /admin/users" do
    it "creates a new user" do
      expect {
        post admin_users_path, params: { user: { email: "newtrader@example.com", password: "password", role: "trader" } }
      }.to change(User, :count).by(1)
      expect(response).to redirect_to(admin_users_path)
      follow_redirect!
      expect(response.body).to include("newtrader@example.com")
    end
  end

  describe "PATCH /admin/users/:id" do
    it "updates the details of an existing user" do
      patch admin_user_path(trader), params: { user: { email: "updatedtrader@example.com" } }
      expect(response).to redirect_to(admin_user_path(trader))
      follow_redirect!
      expect(response.body).to include("updatedtrader@example.com")
      trader.reload
      expect(trader.email).to eq("updatedtrader@example.com")
    end
  end
end
