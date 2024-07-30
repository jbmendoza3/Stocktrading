class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @url  = 'http://doctorirondoom.com/login'
    mail(to: @user.email, subject: 'Welcome to Our Site')
  end
end
