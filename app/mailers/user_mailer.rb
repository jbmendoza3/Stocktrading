class UserMailer < ApplicationMailer
  @user = params[:user]
  @url  = 'http://doctorirondoom.com/login'
  mail(to: @user.email, subject: 'Welcome to Iron Doom')
end
