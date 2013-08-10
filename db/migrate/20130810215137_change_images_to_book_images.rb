class ChangeImagesToBookImages < ActiveRecord::Migration
  def change
    rename_table :images, :book_images
  end
end
