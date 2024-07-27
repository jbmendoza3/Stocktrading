require 'rails_helper'

RSpec.feature "UserManagement", type: :feature do
  describe "Trader Registration" do
    scenario "Trader registers successfully" do
      visit new_user_registration_path
      fill_in "Email", with: "trader@example.com"
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "password"
      click_button "Sign up"
      expect(page).to have_content("Welcome! You have signed up successfully.")
    end

    scenario "Trader cannot register with mismatched password confirmation" do
      visit new_user_registration_path
      fill_in "Email", with: "trader@example.com"
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "different_password"
      click_button "Sign up"
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end

  describe "Trader Login" do
    let(:user) { create(:user, email: "trader@example.com", password: "password", role: :trader) }

    scenario "Trader logs in successfully" do
      visit new_user_session_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"
      expect(page).to have_content("Signed in successfully.")
    end

    scenario "Trader cannot log in with incorrect credentials" do
      visit new_user_session_path
      fill_in "Email", with: user.email
      fill_in "Password", with: "wrong_password"
      click_button "Log in"
      expect(page).to have_content("Invalid Email or password.")
    end
  end

  describe "Admin User Management" do
    let(:admin) { create(:user, email: "admin@example.com", password: "password", role: :admin) }
    let(:user) { create(:user, email: "trader@example.com", password: "password", role: :trader) }

    before do
      sign_in admin
    end

    scenario "Admin views all users" do
      visit admin_users_path
      expect(page).to have_content(user.email)
      expect(page).to have_content(admin.email)
    end

    scenario "Admin views a specific user's details" do
      visit admin_user_path(user)
      expect(page).to have_content(user.email)
      expect(page).to have_content("Role: trader")
    end

    scenario "Admin creates a new user" do
      visit new_admin_user_path
      fill_in "Email", with: "newtrader@example.com"
      fill_in "Password", with: "password"
      select "trader", from: "Role"
      click_button "Create User"
      expect(page).to have_content("User created successfully.")
      expect(page).to have_content("newtrader@example.com")
    end

    scenario "Admin edits a user's details" do
      visit edit_admin_user_path(user)
      fill_in "Email", with: "updatedtrader@example.com"
      click_button "Update User"
      expect(page).to have_content("User updated successfully.")
      expect(page).to have_content("updatedtrader@example.com")
    end
  end
end
