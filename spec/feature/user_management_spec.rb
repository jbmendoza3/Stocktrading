require 'rails_helper'

RSpec.feature 'Admin manages users', type: :feature do
  let(:admin) { create(:user, user_type: 'admin', creation_status: 'approved') }
  let(:trader) { create(:user, user_type: 'trader', creation_status: 'approved') }
  let(:pending_trader) { create(:user, user_type: 'trader', creation_status: 'pending') }

  before do
    login_as(admin, scope: :user)
  end

  scenario 'Admin views approved users' do
    visit admin_users_path

    expect(page).to have_content(admin.email)
    expect(page).to have_content(trader.email)
    expect(page).not_to have_content(pending_trader.email)
  end

  scenario 'Admin creates a new user' do
    visit new_admin_user_path

    fill_in 'Email', with: 'newtrader@example.com'
    fill_in 'Password', with: 'password123'
    fill_in 'Password confirmation', with: 'password123'
    select 'trader', from: 'User type'
    click_button 'Create User'

    expect(page).to have_content('User was successfully created.')
    expect(page).to have_content('newtrader@example.com')
    expect(ActionMailer::Base.deliveries.last.subject).to eq('Your account has been approved')
  end

  scenario 'Admin views pending users' do
    visit pending_users_admin_users_path

    expect(page).to have_content(pending_trader.email)
    expect(page).not_to have_content(admin.email)
    expect(page).not_to have_content(trader.email)
  end

  scenario 'Admin approves a pending user' do
    visit pending_users_admin_users_path

    within("tr#user_#{pending_trader.id}") do
      click_button 'Approve'
    end

    expect(page).to have_content('User status updated successfully.')
    expect(pending_trader.reload.creation_status).to eq('approved')
    expect(ActionMailer::Base.deliveries.last.subject).to eq('Your account has been approved')
  end

  scenario 'Admin deletes a user' do
    visit admin_users_path

    within("tr#user_#{trader.id}") do
      click_button 'Delete'
    end

    expect(page).to have_content('User was successfully deleted.')
    expect(User.exists?(trader.id)).to be_falsey
  end
end
