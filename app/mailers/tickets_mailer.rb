class TicketsMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.tickets_mailer.created.subject
  #
  def created(ticket, to, bcc = [])
    @ticket = ticket

    mail to: to, bcc: bcc
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.tickets_mailer.edited.subject
  #
  def edited(ticket, to, bcc = [])
    @ticket = ticket

    mail to: to, bcc: bcc
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.tickets_mailer.commented.subject
  #
  def commented(ticket, to, bcc = [])
    @ticket = ticket

    mail to: to, bcc: bcc
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.tickets_mailer.commented.subject
  #
  def assignee_changed(ticket, to, bcc = [])
    @ticket = ticket

    mail to: to, bcc: bcc
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.tickets_mailer.status_changed.subject
  #
  def status_changed(ticket, to, bcc = [])
    @ticket = ticket

    mail to: to, bcc: bcc
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.tickets_mailer.sla_breached.subject
  #
  def sla_breached(ticket, to, bcc = [])
    @ticket = ticket

    mail to: to, bcc: bcc
  end
end
