json.extract! ticket, :id, :sequential_id, :identifier, :title, :content, :project_id, :status, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
json.values @ticket.values.map do |tagging|
  puts tagging.tag.name
  json.name tagging.tag.name
  value = "foo"
  case tagging.tag.value_type.to_sym
  when :string
    value = tagging.value
  when :date
    value = tagging.date_value
  when :user
    value = tagging.user_value
  else
    value = tagging.value
  end
  json.type tagging.tag.value_type.to_sym
  json.value value
end
