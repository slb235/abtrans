class Term < ActiveRecord::Base
  belongs_to :project
  has_many :translations


end
