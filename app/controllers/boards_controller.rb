class BoardsController < ApplicationController
  # GET /board/1 or /board/1.json
  def show
    @board = Tag.find(params[:id])
    @tickets = Ticket.includes(:tags).where(tags: { id: params[:id] })
  end

end
