class BoardsController < ApplicationController
  # GET /board/1 or /board/1.json
  def show
    @board = Tag.find(params[:id])
    @tickets = Ticket.includes(:tags).where(tags: { id: params[:id] })

    # TODO: reject alreade approved with a where clause
    # if @board.approval?
    #   @tickets = @tickets.reject(&:approved?)
    # end
  end
end
