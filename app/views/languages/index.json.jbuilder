json.array!(@languages) do |language|
  json.extract! language, :id, :title, :locale, :project_id
  json.url language_url(language, format: :json)
end
