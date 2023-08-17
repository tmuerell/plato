class BoardsController < ApplicationController
  # GET /board/1 or /board/1.json
  def show
    @board = Tag.find(params[:id])
    if @board.project != current_project
      redirect_to root_url
      return
    end

    @tickets = Ticket.with_tag(@board)

    if @board.approval?
      @tickets = @tickets.joins('LEFT OUTER JOIN "ticket_user_relationships" ON "ticket_user_relationships"."ticket_id" = "tickets"."id" AND "ticket_user_relationships"."relationship" = "approval"')
                         .where('ticket_user_relationships.id IS NULL')
    end
    @tickets
  end
end
