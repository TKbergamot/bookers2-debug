# frozen_string_literal: true

class DailyMailer < ApplicationMailer
  default from: 'rails@example.com'

  def send_daily_email(user)
    @user = user
    mail(subject: 'デイリーメール送信', to: user.email)
  end

  def self.send_daily_email_users
    @users = User.all
    @users.each do |user|
      DailyMailer.send_daily_email(user).deliver_now
    end
  end
end
