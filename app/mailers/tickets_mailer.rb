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
  #   en.tickets_mailer.edited.subject
  #
  def edited(ticket, watchers)
    @ticket = ticket

    mail to: watchers.map(&:email)
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

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.tickets_mailer.commented.subject
  #
  def assigned(ticket, user)
    @ticket = ticket

    mail to: user.email
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.tickets_mailer.status_changed.subject
  #
  def status_changed(ticket, watchers)
    @ticket = ticket

    mail to: watchers.map(&:email)
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.tickets_mailer.sla_breached.subject
  #
  def sla_breached(ticket, to)
    @ticket = ticket

    mail to:
  end
end
