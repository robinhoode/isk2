class Book < ActiveRecord::Base
  self.table_name = "book"

  belongs_to :title
  belongs_to :location

  def self.sold
    where(status: "SOLD")
  end

  def self.stock
    where(status: "STOCK")
  end

  def self.deleted
    where(status: "DELETED")
  end

  def our_price
    sprintf "$%.2f", ourprice
  end

  def sold!
    update_attributes status: "SOLD"
  end

end
