class TicketsController < ApplicationController
  load_and_authorize_resource except: :import

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
    @tickets = @tickets.where(status: :new).reject(&:on_board?)
    @boards = Tag.where(is_board: true)
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

  def move
    tag = Tag.find(params[:board_id])
    if !tag.is_board
      render_error_page(status: 403, text: 'Forbidden')
    end
    @ticket.tags << tag
    @ticket.save
    redirect_to @ticket
  end

  def import
    external_id = params[:key]
    t = Ticket.find_by_external_id(external_id)
    cp = CustomerProject.find_or_create_by(name: params[:fields][:customfield_12750][:value])
    priority = if params[:fields][:priority][:name] == 'High'
                 :high
               else
                 :normal
               end
    status = if params[:fields][:status][:name] == 'Open'
               :new
             elsif params[:fields][:status][:name] == 'In Progress'
               :in_progress
             else
               :new
             end
    if t
      t.update(content: params[:fields][:description],
               assignee: find_user(params[:fields][:assignee]),
               title: params[:fields][:summary],
               priority: priority,
               customer_project: cp,
               status: status)
    else
      t = Ticket.create!(external_id: external_id,
                         content: params[:fields][:description],
                         creator: find_user(params[:fields][:creator]),
                         assignee: find_user(params[:fields][:assignee]),
                         title: params[:fields][:summary],
                         project: Project.first,
                         priority: priority,
                         customer_project: cp,
                         status: status)
      if params[:fields][:comment] && params[:fields][:comment][:comments]
        params[:fields][:comment][:comments].each do |c|
          Comment.create!(content: c[:body], creator: find_user(c[:author]), created_at: c[:created], ticket: t)
        end
      end
    end
  end

  protected

  def find_user(det)
    return nil unless det.present?
    User.find_or_create_by(email: det[:emailAddress]) do |user|
      user.password = Devise.friendly_token[0, 20]
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def ticket_params
    params.require(:ticket).permit(:sequential_id, :title, :content, :project_id, :status, :priority, :customer_project_id, :creator_id, :assignee_id, :external_id, :tag_ids => [])
  end
end
