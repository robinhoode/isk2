class Author < ActiveRecord::Base
  self.table_name = "author"

  has_many :author_titles
  has_many :titles, :through => :author_titles
end
