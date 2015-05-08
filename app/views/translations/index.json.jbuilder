json.array!(@translations) do |translation|
  json.extract! translation, :id, :title, :title_plural, :language_id, :term_id
  json.url translation_url(translation, format: :json)
end
