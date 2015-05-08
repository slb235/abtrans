class Project < ActiveRecord::Base
  has_many :terms
  has_many :languages
end
