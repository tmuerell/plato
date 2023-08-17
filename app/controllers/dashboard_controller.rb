class DashboardController < ApplicationController
  def index
    unless current_project
      redirect_to projects_url
    end

  end

  def profile
    @tickets = Ticket.where(assignee: current_user).page params[:page]
  end
end
