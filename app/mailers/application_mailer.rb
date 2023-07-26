class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('PLATO_MAIL_SENDER') { "example@example.com" }
  layout "mailer"
end
