require 'rails_helper'

RSpec.describe Admin::UsersController, type: :request do
  let(:admin) { create(:user, user_type: 'admin') }
  let(:user) { create(:user, creation_status: 'approved') }
  let(:pending_user) { create(:user, creation_status: 'pending') }

  before do
    sign_in admin
  end

  describe "GET #index" do
    it "returns a success response" do
      get admin_users_path
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get admin_user_path(user)
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get new_admin_user_path
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:valid_attributes) { attributes_for(:user) }

      it "creates a new User" do
        expect {
          post admin_users_path, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it "redirects to the users list" do
        post admin_users_path, params: { user: valid_attributes }
        expect(response).to redirect_to(admin_users_path)
      end
    end

    context "with invalid params" do
      let(:invalid_attributes) { attributes_for(:user, email: nil) }

      it "does not create a new User" do
        expect {
          post admin_users_path, params: { user: invalid_attributes }
        }.to change(User, :count).by(0)
      end

      it "renders the new template" do
        post admin_users_path, params: { user: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get edit_admin_user_path(user)
      expect(response).to be_successful
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { email: 'newemail@example.com' } }

      it "updates the requested user" do
        put admin_user_path(user), params: { user: new_attributes }
        user.reload
        expect(user.email).to eq('newemail@example.com')
      end

      it "redirects to the user show page" do
        put admin_user_path(user), params: { user: new_attributes }
        expect(response).to redirect_to(admin_user_path(user))
      end
    end

    context "with invalid params" do
      let(:invalid_attributes) { { email: nil } }

      it "does not update the user" do
        put admin_user_path(user), params: { user: invalid_attributes }
        user.reload
        expect(user.email).not_to be_nil
      end

      it "renders the edit template" do
        put admin_user_path(user), params: { user: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      user
      expect {
        delete admin_user_path(user)
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      delete admin_user_path(user)
      expect(response).to redirect_to(admin_users_path)
    end
  end

  describe "GET #pending_users" do
    it "returns a success response" do
      get pending_users_admin_users_path
      expect(response).to be_successful
    end
  end

  describe "PUT #approve_user" do
    context "with valid params" do
      it "approves the pending user" do
        put approve_user_admin_user_path(pending_user), params: { status: 'approved' }
        pending_user.reload
        expect(pending_user.creation_status).to eq('approved')
      end

      it "redirects to the pending users list" do
        put approve_user_admin_user_path(pending_user), params: { status: 'approved' }
        expect(response).to redirect_to(pending_users_admin_users_path)
      end
    end

    context "with invalid params" do
      it "does not approve the pending user" do
        put approve_user_admin_user_path(pending_user), params: { status: nil }
        pending_user.reload
        expect(pending_user.creation_status).to eq('pending')
      end

      it "redirects to the pending users list with an alert" do
        put approve_user_admin_user_path(pending_user), params: { status: nil }
        expect(response).to redirect_to(pending_users_admin_users_path)
        expect(flash[:alert]).to eq('Failed to update user status.')
      end
    end
  end
end
