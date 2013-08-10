class AuthorTitle < ActiveRecord::Base
  self.table_name = "author_title"

  belongs_to :author
  belongs_to :title
end
