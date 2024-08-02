require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_inclusion_of(:user_type).in_array(%w[trader admin]) }
    it { should validate_inclusion_of(:creation_status).in_array(%w[pending approved]) }
  end

  describe 'callbacks' do
    it 'sets default user type to trader' do
      user = User.new(email: 'test@example.com', password: 'password123')
      user.valid?
      expect(user.user_type).to eq('trader')
    end

    it 'sets default creation status to pending' do
      user = User.new(email: 'test@example.com', password: 'password123')
      user.valid?
      expect(user.creation_status).to eq('pending')
    end

    it 'sends a pending signup email after create if status is pending' do
      user = build(:user, email: 'test@example.com', password: 'password123', creation_status: 'pending')
      expect {
        user.save
      }.to change { ActionMailer::Base.deliveries.count }.by(1)
      expect(ActionMailer::Base.deliveries.last.subject).to eq('Your account is pending approval')
    end

    it 'sends an approval email after create if status is approved' do
      user = build(:user, email: 'test@example.com', password: 'password123', creation_status: 'approved')
      expect {
        user.save
      }.to change { ActionMailer::Base.deliveries.count }.by(1)
      expect(ActionMailer::Base.deliveries.last.subject).to eq('Your account has been approved')
    end
  end
end
