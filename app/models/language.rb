class Language < ActiveRecord::Base
  belongs_to :project
  has_many :translations

  before_save { |language| language.locale.downcase! }

  def translate (term)
    translation = translations.find_by term: term
    unless translation
      translation = Translation.new
      translation.term = term
      translation.language = self
    end
    translation
  end

  def to_s
    title
  end
  
end
