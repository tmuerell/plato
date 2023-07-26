# Preview all emails at http://localhost:3000/rails/mailers/tickets_mailer
class TicketsMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/tickets_mailer/created
  def created
    TicketsMailer.created
  end

  # Preview this email at http://localhost:3000/rails/mailers/tickets_mailer/commented
  def commented
    TicketsMailer.commented
  end

end
