class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @url  = 'http://doctorirondoom.com/login'
    mail(to: @user.email, subject: 'Welcome to Our Site')
  end

  def pending_signup_email
    @user = params[:user]
    @url  = 'http://doctorirondoom.com/login'
    mail(to: @user.email, subject: 'Your account is pending approval')
  end

  def approval_email
    @user = params[:user]
    @url  = 'http://doctorirondoom.com/login'
    mail(to: @user.email, subject: 'Your account has been approved')
  end
end
