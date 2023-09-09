json.extract! ticket, :id, :sequential_id, :title, :content, :project_id, :status, :customer_project_id, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
