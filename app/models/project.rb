class Project < ActiveRecord::Base
  has_many :terms
  has_many :languages

  def default_language
    languages.find(6)
  end

end
