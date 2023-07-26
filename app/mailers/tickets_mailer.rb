class TicketsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.tickets_mailer.created.subject
  #
  def created(ticket, user)
    @ticket = ticket

    mail to: user.email
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.tickets_mailer.commented.subject
  #
  def commented(ticket, user)
    @ticket = ticket

    mail to: user.email
  end
end
