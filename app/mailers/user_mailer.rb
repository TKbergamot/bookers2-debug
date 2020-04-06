# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @url = 'http://example.com/login'
    mail(to: params[:user].email, subject: 'Welcome to my site!')
  end
end
