json.array!(@terms) do |term|
  json.extract! term, :id, :title, :project_id, :plural
  json.url term_url(term, format: :json)
end
