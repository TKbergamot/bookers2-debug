# frozen_string_literal: true

namespace :send_email do
  desc 'send daily email'
  task daily_email: :environment do
    DailyMailer.send_daily_email_users
  end
end
