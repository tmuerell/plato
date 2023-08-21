class SearchController < ApplicationController
  def search
    query = params[:query]

    @tickets = Ticket.search(query, current_project, current_ability)

    if @tickets.count == 1
      redirect_to @tickets.first
    else
      @tickets = @tickets.order(:sequential_id).page params[:page]
      render 'search'
    end
  end
end
