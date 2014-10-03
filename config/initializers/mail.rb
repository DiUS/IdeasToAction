if Rails.env.qa? || Rails.env.production? || Rails.env.development?
  ActionMailer::Base.smtp_settings = {
    address: 'email-smtp.us-west-2.amazonaws.com',
    port: '587',
    authentication: :plain,
    user_name: ENV['AMAZON_SMTP_USERNAME'],
    password: ENV['AMAZON_SMTP_PASSWORD'],
    domain: 'tedxultimo.com',
    enable_starttls_auto: true
  }
else
  ActionMailer::Base.smtp_settings = {
    address: 'localhost',
    port: '2525'
  }
end
