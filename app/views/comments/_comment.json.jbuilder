json.extract! comment, :id, :content, :ticket_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)
