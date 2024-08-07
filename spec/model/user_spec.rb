require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_inclusion_of(:user_type).in_array(%w[trader admin]) }
    it { should validate_inclusion_of(:creation_status).in_array(%w[pending approved]) }
  end

  describe 'callbacks' do
    let(:user) { build(:user, creation_status: 'pending') }
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
  end

  describe 'callbacks' do
    let(:user) { build(:user, creation_status: 'pending') }

    it 'sends a pending signup email after create if status is pending' do
      # Create a mailer instance double
      mailer_double = instance_double("UserMailer::PendingSignupEmail")

      # Stub the UserMailer class
      allow(UserMailer).to receive_message_chain(:with, :pending_signup_email).and_return(mailer_double)
      allow(mailer_double).to receive(:deliver_now)

      user.save

      expect(UserMailer).to have_received(:with).with(user: user)
      expect(UserMailer.with(user: user)).to have_received(:pending_signup_email)
      expect(mailer_double).to have_received(:deliver_now)
    end
  end

  describe 'callbacks' do
    let(:user) { build(:user, creation_status: 'approved') }

    it 'sends an approval email after create if status is approved' do
      # Create a mailer instance double
      mailer_double = instance_double("UserMailer::ApprovalEmail")

      # Stub the UserMailer class
      allow(UserMailer).to receive_message_chain(:with, :approval_email).and_return(mailer_double)
      allow(mailer_double).to receive(:deliver_now)

      user.save

      expect(UserMailer).to have_received(:with).with(user: user)
      expect(UserMailer.with(user: user)).to have_received(:approval_email)
      expect(mailer_double).to have_received(:deliver_now)
    end
  end
end
