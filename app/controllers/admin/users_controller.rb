class Admin::UsersController < ApplicationController
    before_action :authorize_admin!
    before_action :set_user, only: [:edit, :update, :destroy, :show, :approve_user]
  
    def index
      @users = User.where(creation_status: 'approved')
    end

    def show
    end
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      @user.creation_status = "approved"
      if @user.save
        redirect_to admin_users_path, notice: 'User was successfully created.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @user.update(user_params)
        redirect_to admin_users_path, notice: 'User was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @user.destroy
      redirect_to admin_users_path, notice: 'User was successfully deleted.'
    end

    def pending_users
      @users = User.where(creation_status: "pending")
    end

    def approve_user
      if @user.update(creation_status: params[:status])
        redirect_to pending_users_admin_users_path, notice: 'User status updated successfully.'
      else
        redirect_to pending_users_admin_users_path, alert: 'Failed to update user status.'
      end
    end
  
    private
  
    def set_user
      @user = User.find(params[:id])
    end
  
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :user_type, :creation_status)
    end
  end
  