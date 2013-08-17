require 'open-uri'

class Title < ActiveRecord::Base
  self.table_name = "title"

  include Tire::Model::Search
  include Tire::Model::Callbacks

  mapping do
    indexes :id, index: :not_analyzed

    indexes :booktitle,    analyzer: 'snowball', boost: 100
    indexes :publisher,    analyzer: 'snowball'
    indexes :author_names, analyzer: 'snowball', as: "author_names"
  end


  has_many :author_titles
  has_many :authors, :through => :author_titles
  has_many :books

  has_one :book_image

  def attach_image!
    if self.book_image.blank?
      book_image = BookImage.create!(title_id: id)
      book_image.attach_image!(image_file_url)
    elsif self.book_image.image_file.blank?
      self.book_image.attach_image!(image_file_url)
    end
  end

  def image_url
    if book_image.present?
      book_image.image_file.url rescue ""
    else
      ""
    end
  end

  def image_file_url
    "http://www2.alibris-static.com/isbn/#{isbn}.gif"
  end

  def available_copies
    books.where(status: 'STOCK')
  end

  def locations
    books.map {|b| b.location.name rescue nil }.uniq.reject(&:blank?)
  end

  def self.inheritance_column
    :none
  end

  def self.t
    arel_table
  end

  def self.search_book_name(term)
    t[:booktitle].matches("%#{term}%")
  end

  def self.search_publisher(term)
    t[:publisher].matches("%#{term}%")
  end

  def self.search_isbn(term)
    t[:isbn].matches("%#{term}%").or(t[:isbn13].matches("%#{term}%"))
  end

  def self.search_author_name(term)
    a = Author.arel_table
    a[:author_name].matches("%#{term}%")
  end

  def self.search(term)
    queries = term.split(' ').map {|t| queries_for(t) }

    where(queries.flatten.reduce(:or)).includes(:authors).references(:authors)
  end

  def self.queries_for(string)
    if string =~ /^[0-9]*$/
      term = string[0..12]
    else
      term = string
    end

    [
     search_book_name(term),
     # search_publisher(term),
     search_isbn(term),
     search_author_name(term)
    ]
  end

  def author_names
    authors.map(&:author_name).join(" ")
  end
end
