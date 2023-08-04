class ImportController < ApplicationController
  respond_to :json

  def user
    authorize! :import, Ticket

    @user = User.find_or_create_by(email: params[:email]) do |user|
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def customer_project
    authorize! :import, Ticket

    cp = CustomerProject.find_or_create_by(name: params[:name])
    respond_with(cp)
  end

  def comment
    authorize! :import, Ticket

    comment = Comment.create!(params.permit(:content, :ticket_id, :creator_id, :created_at))

    respond_with(comment)
  end

  def ticket
    authorize! :import, Ticket

    t = Ticket.find_by_external_id(params[:ref])

    unless t
      t = Ticket.find(params[:ref])
    end

    respond_with(t)
  end

  def ticket_update
    authorize! :import, Ticket

    t = Ticket.find_by_external_id(params[:external_id])

    if t
      t.update(params.permit(:sequential_id, :title, :content, :project_id, :status, :priority, :customer_project_id, :creator_id, :assignee_id, :external_id, :tag_ids => []))
    else
      t = Ticket.create!(params.permit(:sequential_id, :title, :content, :project_id, :status, :priority, :customer_project_id, :creator_id, :assignee_id, :external_id, :tag_ids => []))
    end

    respond_with(t)
    # def import
    #   external_id = params[:key]
    #   t = Ticket.find_by_external_id(external_id)
    #   cp = CustomerProject.find_or_create_by(name: params[:fields][:customfield_12750][:value])
    #   priority = if params[:fields][:priority][:name] == 'High'
    #                :high
    #              else
    #                :normal
    #              end
    #   status = if params[:fields][:status][:name] == 'Open'
    #              :new
    #            elsif params[:fields][:status][:name] == 'In Progress'
    #              :in_progress
    #            else
    #              :new
    #            end
    #   if t
    #     t.update(content: params[:fields][:description],
    #              assignee: find_user(params[:fields][:assignee]),
    #              title: params[:fields][:summary],
    #              priority: priority,
    #              customer_project: cp,
    #              status: status)
    #   else
    #     t = Ticket.create!(external_id: external_id,
    #                        content: params[:fields][:description],
    #                        creator: find_user(params[:fields][:creator]),
    #                        assignee: find_user(params[:fields][:assignee]),
    #                        title: params[:fields][:summary],
    #                        project: Project.first,
    #                        priority: priority,
    #                        customer_project: cp,
    #                        status: status)
    #     if params[:fields][:comment] && params[:fields][:comment][:comments]
    #       params[:fields][:comment][:comments].each do |c|
    #         Comment.create!(content: c[:body], creator: find_user(c[:author]), created_at: c[:created], ticket: t)
    #       end
    #     end
    #   end
    # end
  end

  protected

  def find_user(email)

  end
end