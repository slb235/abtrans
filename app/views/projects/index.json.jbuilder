json.array!(@projects) do |project|
  json.extract! project, :id, :title, :kind
  json.url project_url(project, format: :json)
end
