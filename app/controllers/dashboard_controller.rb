class DashboardController < ApplicationController
  def index
  end

  def profile
    @tickets = Ticket.where(assignee: current_user).page params[:page]
  end
end
