class TicketsController < ApplicationController
  load_and_authorize_resource

  # GET /tickets or /tickets.json
  def index
    @tickets = Ticket.all
    if current_project
      @tickets = @tickets.where(project: current_project)
    end
  end

  def inbox
    @tickets = Ticket.all
    if current_project
      @tickets = @tickets.where(project: current_project)
    end
    @tickets = @tickets.where(status: :new)
    @boards = Tag.where(is_board: true)
  end

  # GET /tickets/board/1 or /tickets/board/1.json
  def board
    @board = Tag.find(params[:id])
    @tickets = Ticket.includes(:tags).where('tags.id' => params[:id])
  end

  # GET /tickets/1 or /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets or /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.creator = current_user
    @ticket.project = current_project

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to ticket_url(@ticket), notice: "Ticket was successfully created." }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1 or /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to ticket_url(@ticket), notice: "Ticket was successfully updated." }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  def mine
    @ticket.assignee = current_user
    @ticket.save
    redirect_to @ticket
  end

  # DELETE /tickets/1 or /tickets/1.json
  def destroy
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to tickets_url, notice: "Ticket was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def move_to_board
    tag = Tag.find(params[:id])
    @ticket.tags << tag
    @ticket.save
    redirect_to @ticket
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ticket_params
      params.require(:ticket).permit(:sequential_id, :title, :content, :project_id, :status, :priority, :customer_project_id, :creator_id, :assignee_id, :tag_ids => [])
    end
end
